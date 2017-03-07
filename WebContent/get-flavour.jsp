<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="function"%>
 
<c:set var="p" value="${sessionScope.flavour}"></c:set>
<c:set var="len" value="${function:length(p)}"></c:set>

[<c:forEach items="${sessionScope.flavour}" var="i" varStatus="j">{"flavourid":"${i.fid}","flavourname":"${i.name}"}
<c:if test="${len ne j.count}">,</c:if>
</c:forEach>]



