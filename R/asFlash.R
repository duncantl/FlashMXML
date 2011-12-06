#
# Functions to take an R object and put them into flash data types
# such as XMLList, etc.

setClass("XMLList", contains = "XMLInternalNode")
setClass("XMLCollection", contains = "XMLInternalNode")
setClass("XMLArrayCollection", contains = "XMLCollection")


MXMLns = c(mx = "http://www.adobe.com/2006/mxml")

XMLList =
function(val, id = "",  elName = "el", namespaceDefinitions = MXMLns)
{
   top = newXMLNode("mx:XMLList", namespaceDefinitions = namespaceDefinitions)

   makeEls(val, elName, top)

   top          
}

makeObjects =
function(val, elName = "mx:Object", top = NULL, rownames = "id")
{
   if(is.logical(rownames))
      if(rownames)
         rownames = "id"
      else
         rownames = character()
   
   if(length(rownames)) {
     idx = seq(length = ncol(val))
     val[[rownames]] = rownames(val)
        # reorder so the rownames come first.
     val = val[c(ncol(val), idx)]
   }
   sapply(seq(length = nrow(val)),
           function(i) {
              vals = as.character(val[i,])
              names(vals) = names(val)
              node = newXMLNode(elName, parent = top,
                                 attrs = vals)
           })
}   


makeEls =
function(val, elName = "el", top = NULL)
{  
   sapply(seq(length = nrow(val)),
           function(i) {
              node = newXMLNode(elName, parent = top)
              sapply(names(val),
                       function(id)
                           newXMLNode(id, val[i, id], parent = node))
           })
}   



setAs("data.frame", "XMLList",
       function(from) {
         XMLList(from)
       })


mxArrayCollection =
function(data, parent = NULL, rownames = "id")
{
  ar = newXMLNode("mx:ArrayCollection", namespaceDefinitions = MXMLns, parent = parent)
  makeObjects(data, "mx:Object", ar)
  ar   
}


mxDataGrid =
function(val, attrs = character(), rownames = "id") #??? id or is this used?
{
  dg = newXMLNode("mx:DataGrid", attrs = attrs, namespaceDefinitions = MXMLns)

  cols = newXMLNode("mx:columns", parent = dg)
  sapply(names(val), function(id) newXMLNode("mx:DataGridColumn", attrs = c(headerText = id, dataField = id), parent = cols))

  prov = newXMLNode("mx:dataProvider", parent = dg)
  mxArrayCollection(val, prov)

  invisible(dg)
}  

setGeneric("mxType", function(type) standardGeneric("mxType"))

mxTypeTable = 
  c("character" = "mx:String",
    "integer" = "mx:Integer",
    "numeric" = "mx:Number"
    )

setMethod("mxType", "character",
           function(type) {
               if(type %in% names(mxTypeTable))
                  mxTypeTable[type]
               else
                  "Object" # Or perhaps class of the object?
           })


setMethod("mxType", "vector",
            function(type) {
              mxType(typeof(type))
            })

setAs("vector", "XMLArrayCollection",
       function(from) {
         ar = newXMLNode("mx:ArrayCollection", namespaceDefinitions = MXMLns)
         array = newXMLNode("mx:Array", parent = ar)
         elType = mxType(class(from))
         sapply(from, function(el) newXMLNode(elType, el, parent = array))
         ar
       })
