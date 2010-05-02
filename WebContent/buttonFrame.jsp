<%--
 Copyright (C) 2009  HungryHobo@mail.i2p
 
 The GPG fingerprint for HungryHobo@mail.i2p is:
 6DD3 EAA2 9990 29BC 4AD2 7486 1E2C 7B61 76DC DC12
 
 This file is part of I2P-Bote.
 I2P-Bote is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 I2P-Bote is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with I2P-Bote.  If not, see <http://www.gnu.org/licenses/>.
 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ib" uri="I2pBoteTags" %>

<jsp:include page="getStatus.jsp"/>

<c:if test="${param.checkMail == 1}">
    <ib:checkForMail/>
</c:if>

<c:if test="${ib:isCheckingForMail()}">
    <c:set var="checkingForMail" value="true"/>
</c:if>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="i2pbote.css" />
    <c:if test="${checkingForMail}">
        <meta http-equiv="refresh" content="20;url=buttonFrame.jsp" />
    </c:if>
</head>

<body style="background-color: transparent; margin: 0px;">

<c:set var="disable" value=""/>
<c:if test="${connStatus == DELAY}">
    <c:set var="disable" value="disabled=&quot;disabled&quot;"/>
</c:if>

<table><tr>
    <td>
        <c:if test="${checkingForMail}">
            <div class="checkmail">
                <img src="images/wait.gif"/><ib:message key="Checking for mail..."/>
            </div>
        </c:if>
        <c:if test="${!checkingForMail}">
            <div class="checkmail">
                <c:choose>
                    <c:when test="${empty ib:getIdentities().all}">
                        <c:set var="url" value="noIdentities.jsp"/>
                        <c:set var="frame" value="target=&quot;_parent&quot;"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="link" value="buttonFrame.jsp"/>
                        <c:set var="frame" value=""/>
                    </c:otherwise>
                </c:choose>
                
                <form action="${url}" ${frame} method="GET">
                    <input type="hidden" name="checkMail" value="1"/>
                    <button type="submit" value="Check Mail/>" ${disable}><ib:message key="Check Mail"/></button>
                </form>
            </div>
            <c:if test="${ib:newMailReceived()}">
                <script language="Javascript">
                // If inbox is being displayed, reload so the new email(s) show
                if (parent.document.getElementById('inboxFlag'))
                    parent.location = 'folder.jsp?path=Inbox';
                </script>
            </c:if>
        </c:if>
    </td>
    <td>
        <form action="newEmail.jsp" target="_top" method="GET">
            <button type="submit" value="New" ${disable}><ib:message key="New"/></button>
        </form>
    </td>
</tr></table>

</body>
</html>