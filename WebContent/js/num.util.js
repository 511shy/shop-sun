//****************************************************************
//* 名　　称：DataLength
//* 功    能：计算数据的长度
//* 入口参数：fData：需要计算的数据
//* 出口参数：返回fData的长度(Unicode长度为2，非Unicode长度为1)
//*****************************************************************
function DataLength(fData)
{
    var intLength=0
    for (var i=0;i<fData.length;i++)
    {
        if ((fData.charCodeAt(i) < 0) || (fData.charCodeAt(i) > 255))
            intLength=intLength+2
        else
            intLength=intLength+1    
    }
    return intLength
}


//****************************************************************
//* 名　　称：DataLength
//* 功    能：计算数据的长度
//* 入口参数：fData：需要计算的数据
//* 出口参数：返回fData的长度(Unicode长度为2，非Unicode长度为1)
//*****************************************************************
function DataLength(fData)
{
    var intLength=0
    for (var i=0;i<fData.length;i++)
    {
        if ((fData.charCodeAt(i) < 0) || (fData.charCodeAt(i) > 255))
            intLength=intLength+2
        else
            intLength=intLength+1    
    }
    return intLength
} 

//****************************************************************
//* 名　　称：IsEmpty
//* 功    能：判断是否为空
//* 入口参数：fData：要检查的数据
//* 出口参数：True：空                              
//*           False：非空
//*****************************************************************
function IsEmpty(fData)
{
    return ((fData==null) || (fData.length==0) )
} 


//****************************************************************
//* 名　　称：IsDigit
//* 功    能：判断是否为数字
//* 入口参数：fData：要检查的数据
//* 出口参数：True：是0到9的数字                              
//*           False：不是0到9的数字 
//*****************************************************************
function IsDigit(fData)
{
    return ((fData>="0") && (fData<="9"))
} 


//****************************************************************
//* 名　　称：IsInteger
//* 功    能：判断是否为正整数
//* 入口参数：fData：要检查的数据
//* 出口参数：True：是整数，或者数据是空的                            
//*           False：不是整数
//*****************************************************************
function IsInteger(fData)
{
    //如果为空，返回true
    if (IsEmpty(fData))
        return true
    if ((isNaN(fData)) || (fData.indexOf(".")!=-1) || (fData.indexOf("-")!=-1))
        return false    
    
    return true    
} 

//****************************************************************
//* 名　　称：IsNoEmptyInteger
//* 功    能：判断是否为正整数
//* 入口参数：fData：要检查的数据
//* 出口参数：True：是整数，并且不为空 ,不为零              
//*           False：不是整数,或者是空,或为零
//*****************************************************************
function IsNoEmptyInteger(fData)
{
    //如果为空，返回true
	if(fData==0)
		return false;
    if (IsEmpty(fData))
        return false;
    if ((isNaN(fData)) || (fData.indexOf(".")!=-1) || (fData.indexOf("-")!=-1))
        return false    
    
    return true    
} 

//****************************************************************
//* 名　　称：IsEmail
//* 功    能：判断是否为正确的Email地址
//* 入口参数：fData：要检查的数据
//* 出口参数：True：正确的Email地址，或者空                              
//*           False：错误的Email地址
//*****************************************************************
function IsEmail(fData)
{
    if (IsEmpty(fData))
        return true
    if (fData.indexOf("@")==-1)
        return false
    var NameList=fData.split("@");
    if (NameList.length!=2)
        return false  
    if (NameList[0].length<1 )
        return false   
    if (NameList[1].indexOf(".")<=0)
        return false 
    if (fData.indexOf("@")>fData.indexOf(".")) 
 return false
    if (fData.indexOf(".")==fData.length-1)
 return false
    
    return true    
} 

//****************************************************************
//* 名　　称：IsPhone
//* 功    能：判断是否为正确的电话号码（可以含"()"、"（）"、"+"、"-"和空格）
//* 入口参数：fData：要检查的数据
//* 出口参数：True：正确的电话号码，或者空                              
//*           False：错误的电话号码
//* 错误信息：
//*****************************************************************
function IsPhone(fData)
{
    var str;
    var fDatastr="";
    if (IsEmpty(fData))
        return true
    for (var i=0;i<fData.length;i++)
    {
        str=fData.substring(i,i+1);
        if (str!="(" && str!=")" && str!="（" && str!="）" && str!="+" && str!="-" && str!=" ")
           fDatastr=fDatastr+str;
    }  
    //alert(fDatastr);  
    if (isNaN(fDatastr))
        return false 
    return true    
} 

//****************************************************************
//* 名　　称：IsPlusNumeric
//* 功    能：判断是否为正确的正数（可以含小数部分）
//* 入口参数：fData：要检查的数据
//* 出口参数：True：正确的正数，或者空                              
//*           False：错误的正数
//* 错误信息：
//*****************************************************************
function IsPlusNumeric(fData)
{
    if (IsEmpty(fData))
        return true
    if ((isNaN(fData)) || (fData.indexOf("-")!=-1))
        return false 
    return true    
} 




//****************************************************************
//* 名　　称：IsNumeric
//* 功    能：判断是否为正确的数字（可以为负数，小数）
//* 入口参数：fData：要检查的数据
//* 出口参数：True：正确的数字，或者空                              
//*           False：错误的数字
//* 错误信息：
//*****************************************************************
function IsNumeric(fData)
{
    if (IsEmpty(fData))
        return true
    if (isNaN(fData))
        return false
        
    return true    
} 


//****************************************************************
//* 名　　称：IsIntegerInRange
//* 功    能：判断一个数字是否在指定的范围内
//* 入口参数：fInput：要检查的数据
//*           fLower：检查的范围下限，如果没有下限，请用null
//*           fHigh：检查的上限，如果没有上限，请用null
//* 出口参数：True：在指定的范围内                              
//*           False：超出指定范围
//*****************************************************************
function IsIntegerInRange(fInput,fLower,fHigh)
{
    if (fLower==null)
        return (fInput<=fHigh)
    else if (fHigh==null)
        return (fInput>=fLower) 
    else         
        return ((fInput>=fLower) && (fInput<=fHigh))
}
