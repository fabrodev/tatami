<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="includes/header.jsp"/>

<body>

<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="/tatami/"><img
                    src="/assets/img/ippon-logo.png">&nbsp;<spring:message
                    code="tatami.title"/></a>

            <div class="nav-collapse">
                <ul class="nav">
                    <li class="active"><a href="/tatami/"><i class="icon-home icon-white"></i>&nbsp;<spring:message
                            code="tatami.home"/></a></li>
                    <li><a href="/tatami/about"><i class="icon-info-sign icon-white"></i>&nbsp;<spring:message
                            code="tatami.about"/></a></li>
                </ul>
                <ul class="nav pull-right">
                    <li class="divider-vertical"></li>
                    <li><a href="/tatami/logout"><i class="icon-user icon-white"></i>&nbsp;<spring:message
                            code="tatami.logout"/></a></li>
                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
    </div>
</div>

<div class="container-fluid" id="userProfile">
    <c:choose>
        <c:when test="${not empty user}">

            <div id="userProfileDesc" class="row-fluid">
                <div class="span2">
                    <img id="userPicture" src="http://www.gravatar.com/avatar/${user.gravatar}/>?s=128" rel="popover"/>
                </div>
                <div class="span7">
                    <h1>${user.firstName}&nbsp;${user.lastName}</h1>
                    <span><a href="/tatami/profile/${user.login}"
                             title="${user.firstName}&nbsp;${user.lastName}">@${user.login}</a></span>
                </div>
                <div class="span3">
                    <ul id="profileStats">
                        <sec:authentication property='principal.username' var="login"/>
                        <c:choose>
                            <c:when test="${not empty user && user.login eq login}">
                                <li>
                                    <a href="#" id="followBtn" class="btn btn-inverse disabled"
                                       title="You are"><spring:message code="tatami.user.yourself"/></a>
                                </li>
                            </c:when>
                            <c:when test="${not empty followed && followed}">
                                <li>
                                    <a href="#" id="unfollowBtn"
                                       onclick="removeFollowingAUserFromHisProfile(login, '${user.login}')"
                                       class="btn btn-info"
                                       title="${user.firstName}&nbsp;${user.lastName}"><spring:message
                                            code="tatami.user.followed"/></a>
                                    <a href="#" id="followBtn"
                                       onclick="followUserFromHisProfile(login, '${user.login}')"
                                       class="btn btn-success hide"
                                       title="${user.firstName}&nbsp;${user.lastName}"><spring:message
                                            code="tatami.user.follow"/></a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li>
                                    <a href="#" id="unfollowBtn"
                                       onclick="removeFollowingAUserFromHisProfile(login, '${user.login}')"
                                       class="btn btn-info"
                                       title="${user.firstName}&nbsp;${user.lastName}"><spring:message
                                            code="tatami.user.followed"/></a>
                                    <a href="#" id="followBtn"
                                       onclick="followUserFromHisProfile(login, '${user.login}')"
                                       class="btn btn-success hide"
                                       title="${user.firstName}&nbsp;${user.lastName}"><spring:message
                                            code="tatami.user.follow"/></a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                        <li class="bottomline">
                            <strong><fmt:formatNumber value="${nbTweets}"
                                                      pattern="# ### ###"/></strong>&nbsp;<spring:message
                                code="tatami.user.nbTweets"/>
                        </li>
                        <li class="bottomline">
                            <strong><fmt:formatNumber value="${nbFollowed}"
                                                      pattern="# ### ###"/></strong>&nbsp;<spring:message
                                code="tatami.user.nbFollowedUsers"/>
                        </li>
                        <li class="bottomline">
                            <strong><fmt:formatNumber value="${nbFollowers}"
                                                      pattern="# ### ###"/></strong>&nbsp;<spring:message
                                code="tatami.user.nbFollowers"/>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="row-fluid">
                <div id="profilemenuleft" class="span3">
                    <div class="row-fluid">
                        <h2><spring:message code="tatami.user.tweettohim"/>&nbsp;:</h2>

                        <div id="tweetToHim" class="row-fluid">
                            <c:set var="tweetTo" value="@${user.login}"/>
                            <form class="form-inline" onsubmit="return tweet();">
                                <textarea id="tweetContent" rel="popover" class="focused" maxlength="140"
                                          placeholder="Type here..."></textarea>
                                <button type="submit" class="btn btn-primary"><spring:message
                                        code="tatami.user.tweet"/></button>
                            </form>
                            <div class="error"></div>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <h2><spring:message code="tatami.user.suggestions"/>&nbsp;:</h2>

                        <div id="suggestions" class="row-fluid"></div>
                    </div>
                </div>
                <div id="userTimeline" class="span9">


                </div>
            </div>

        </c:when>
        <c:otherwise>

            <div class="row-fluid">
                <a href="#" title="404">
                    <img src="/tatami/assets/img/judoka_prise_404.jpg"/>
                </a>
                <spring:message code="tatami.user.undefined"/>
            </div>

        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="includes/footer.jsp"/>

</body>
</html>