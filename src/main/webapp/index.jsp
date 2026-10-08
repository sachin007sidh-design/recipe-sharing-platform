<%-- Entry point: send visitors to the home servlet which loads the latest recipes --%>
<% response.sendRedirect(request.getContextPath() + "/home"); %>
