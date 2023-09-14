
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="JSON.JSONObject, JSON.JSONArray,JSON.JSONException" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Dashboard</title>


        <meta name="description" content="overview &amp; stats" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />		

        <link href="css/bootstrap.min.css" rel="stylesheet" />
        <link href="css/bootstrap-responsive.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/font-awesome.min.css" />
        <!--<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />-->		

        <link rel="stylesheet" href="css/googleapis-font.css" />
        <link rel="stylesheet" href="css/ace.min.css" />
        <link rel="stylesheet" href="css/ace-responsive.min.css" />
        <link rel="stylesheet" href="css/ace-skins.min.css" />
        <link rel="stylesheet" href="css/main.css" />

        <link rel="stylesheet" href="css/loader.css" />


        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>-->
        <!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>-->

        <!--<link rel="stylesheet" href="https://cdn.datatables.net/1.10.18/css/jquery.dataTables.min.css" type="text/css"/>-->

        <!--<script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js" type="text/javascript"></script>-->

        <script src="js/jquery.min.js"></script>
        <link rel="stylesheet" href="css/dataTables1.10.18.min.css" />
        <script src="js/dataTables1.10.18.min.js"></script>

        <link rel="stylesheet" href="css/jquery-ui-1.12.1.css">
        <script src="js/jquery-ui-1.12.1.js"></script>
        <!--        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
                <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>-->

        <link rel="stylesheet" href="css/font-awesome2.min.css" />

        <link rel="stylesheet" href="css/customer-notification.css" />
        <script src="js/customer-notification.js"></script>

        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

        <script src="js/customer.js"></script>

        <style>
            .hideColumn {
                display: none;
            }
            .align-right {
                text-align: right;
                float: right;
            }
        </style>

        <script>
            $(document).ready(function() {

                $("#noOfSelect").val($("select").length);
                console.log($("#noOfSelect").val());

                var set_image = $("#set_image").prop("src").toString().split(",");
                if (set_image[1] === "NotFound")
                {
                    $("#default_image_a").css("display", "block");
                    $("#set_image_a").css("display", "none");
                }


                $("#adv_to_date").change(function() {

                    var uploadFromDate = $('#adv_from_date').val();

                    console.log(uploadFromDate);

                    if (uploadFromDate === "")
                    {
                        //alert("Please Select Open Date First!");
                        bootbox.dialog("Please enter From Date First!", [{"label": "ok", "class": "btn-small btn-primary"}]);
                        $('#adv_to_date').val('');
                        return false;
                    }

                    else
                    {
                        console.log("else");
                    }
                });


                $("#adv_from_date").keyup(function() {
//                    console.log($(this).val());
                    var from_date = $(this).val();
                    if (from_date !== "")
                    {
//                        console.log("len: " + from_date.length);
                        if (from_date.length === 2)
                        {
                            if (from_date > 31)
                            {
                                alert("Enter valid day!");
                                return false;
                            }
                            $(this).val(from_date + "-");
                        }
                        if (from_date.length === 5)
                        {
                            var month = from_date.substr(from_date.indexOf("-") + 1, 2);
                            console.log("month: " + month);
                            if (month > 12)
                            {
                                alert("Enter valid month!");
                                return false;
                            }
                            $(this).val(from_date + "-");
                        }
                        if (from_date.length > 10)
                        {

                        }
                    }
                });

                $("#adv_to_date").keyup(function() {
//                    console.log($(this).val());
                    var from_date = $(this).val();
                    if (from_date !== "")
                    {
//                        console.log("len: " + from_date.length);
                        if (from_date.length === 2)
                        {
                            if (from_date > 31)
                            {
                                alert("Enter valid day!");
                                return false;
                            }
                            $(this).val(from_date + "-");
                        }
                        if (from_date.length === 5)
                        {
                            var month = from_date.substr(from_date.indexOf("-") + 1, 2);
                            console.log("month: " + month);
                            if (month > 12)
                            {
                                alert("Enter valid month!");
                                return false;
                            }
                            $(this).val(from_date + "-");
                        }
                        if (from_date.length > 10)
                        {

                        }
                    }
                });

                $("#adv_from_date").blur(function() {
//                    console.log($(this).val());
                    var from_date = $(this).val();
                    if (from_date !== "")
                    {
                        if (from_date.length > 10)
                        {
                            alert("Enter valid date!");
                            return false;
                        }
                        var from_min_date = $("#adv_from_date").datepicker("option", "minDate");
                        console.log("from_min_date: " + from_min_date);

                        var today = new Date();
                        console.log("today: " + today);

                        var from = from_date.split("-");
                        var fromDateEntered = new Date(from[2], from[1] - 1, from[0]);
                        console.log("entered: " + fromDateEntered);

                        var parseMinDate = Date.parse(from_min_date);
                        var parseTodayDate = Date.parse(today);
                        var parseValueEntered = Date.parse(fromDateEntered);

                        console.log("parseMinDate: " + parseMinDate);
                        console.log("parseValueEntered " + parseValueEntered);
                        console.log("parseTodayDate " + parseTodayDate);
                        console.log("parseValueEntered - parseMinDate : " + (parseValueEntered - parseMinDate));
                        console.log(" : " + (parseValueEntered < parseMinDate));

                        if (parseValueEntered < parseMinDate)
                        {
                            alert('From date must be equal to or greater than 01-09-2018');
                            return false;
                        }
                        if (parseValueEntered > parseTodayDate)
                        {
                            alert('From date can not be future date!');
                            return false;
                        }
                        $("#adv_to_date").datepicker("option", "minDate", $("#adv_from_date").datepicker("getDate"));
                    }
                });


                $("#adv_to_date").blur(function() {
//                    console.log($(this).val());
                    var from_date = $(this).val();
                    if (from_date !== "")
                    {
                        if (from_date.length > 10)
                        {
                            alert("Enter valid date!");
                            return false;
                        }
                        var from_min_date = $("#adv_to_date").datepicker("option", "minDate");
                        console.log("from_min_date: " + from_min_date);

                        var today = new Date();
                        console.log("today: " + today);

                        var from = from_date.split("-");
                        var fromDateEntered = new Date(from[2], from[1] - 1, from[0]);
                        console.log("entered: " + fromDateEntered);

                        var parseMinDate = Date.parse(from_min_date);
                        var parseTodayDate = Date.parse(today);
                        var parseValueEntered = Date.parse(fromDateEntered);

                        console.log("parseMinDate: " + parseMinDate);
                        console.log("parseValueEntered " + parseValueEntered);
                        console.log("parseTodayDate " + parseTodayDate);
                        console.log("parseValueEntered - parseMinDate : " + (parseValueEntered - parseMinDate));
                        console.log(" : " + (parseValueEntered < parseMinDate));

                        if (parseValueEntered < parseMinDate)
                        {
                            alert('To date must be equal to or greater than from date');
                            return false;
                        }
                        if (parseValueEntered > parseTodayDate)
                        {
                            alert('From date can not be future date!');
                            return false;
                        }

                    }
                });
//                $("#overlay").css("display", "none");
                $("#adv_from_date").datepicker({
                    dateFormat: 'dd-mm-yy',
                    maxDate: 0,
                    minDate: new Date('2018/09/01'),
                    onSelect: function(dateText, inst) {
                        $("#adv_to_date").datepicker("option", "minDate", $("#adv_from_date").datepicker("getDate"));
                    }
                });

                $("#adv_to_date").datepicker({dateFormat: 'dd-mm-yy', maxDate: 0});


            });
        </script>
    </head>

    <body onload="">

        <%@include file = "templatecustomer.jsp" %>

        <!--        <div id="overlay">
                    <div id="loader"></div>
                </div>-->

        <input type="hidden" id="sessionCustomerId" value="${customerid}">
        <div class="breadcrumbs" id="breadcrumbs">
            <ul class="breadcrumb">
                <li class="align-center">
                    <h4>Project Documents</h4>

                </li>
                <!--<li class="active">Response Comment</li>-->						
            </ul>
            <div class="nav-search" id="nav-search">
                <a href="redirectcustomerhome.do"><h5><b>Go to Home</b></h5></a>
            </div>
        </div>
        <div class="page-content">
            <div class="panel panel-shadow">
                <div class="panel-body">
                    <div class="row-fluid">
                        <div class="span12">
                            <form class="form-vertical">
                                <input type="hidden" id="userRole" value="${userRole}">
                                <input type="hidden" id="sessionCustomerId" value="${customerid}">
                                <input type="hidden" name="dmsip" id="dmsip" value="${dmsip}">
                                <input type="hidden" name="noOfSelect" id="noOfSelect" value="">
                                <div class="row-fluid">
                                    <%                    if (session.getAttribute("userRole").equals("Admin")) {
                                    %>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="customerId">Customer Name</label>
                                            <div class="controls">
                                                <div class="">
                                                    <select id="customerId" name="customerId" class="span10 search-doc-form-field" required>
                                                        <option>--Select--</option>
                                                        <c:forEach var="customer" items="${customerList}" varStatus="status">
                                                            <option value="${customer.customercode}">${customer.customername}</option>
                                                        </c:forEach>
                                                    </select>

                                                </div>
                                            </div>																
                                        </div>
                                    </div>
                                    <%                                        }
                                    %>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="projectId">Project Name</label>
                                            <div class="controls">
                                                <div class="">

                                                    <select name="projectId" id="projectId" class="span10 search-doc-form-field">
                                                        <option value="">--Select--</option>
                                                        <%                    if (session.getAttribute("userRole").equals("Company Admin")) {
                                                        %>
                                                        <c:forEach var="project" items="${projectListByCutomer}" varStatus="status">
                                                            <option value="${project.projectcode}">${project.projectname}</option>
                                                        </c:forEach>
                                                        <%
                                                        } else if (!session.getAttribute("userRole").equals("Admin")) {
                                                        %>
                                                        <c:forEach var="mapping" items="${projectList}" varStatus="status">
                                                            <option value="${mapping.bpaasProjectseededPid.projectcode}">${mapping.bpaasProjectseededPid.projectname}</option>
                                                        </c:forEach>
                                                        <%
                                                            }
                                                        %>
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row-fluid">

                                </div>

                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="">Document Name</label>
                                            <div class="controls">
                                                <div class="">
                                                    <select id="docType1" name="adv_docType" class="span10 search-doc-form-field check-duplicate-category">
                                                        <option>--Select--</option>
                                                        <%                    if (session.getAttribute("userRole").equals("Admin") || session.getAttribute("userRole").equals("Company Admin")) {
                                                        %>
                                                        <c:forEach var="doc" items="${docList}" varStatus="status">
                                                            <option value="${doc.documentAlias}">${doc.documentname}</option>
                                                        </c:forEach>
                                                        <%} else {
                                                        %>
                                                        <c:forEach var="group" items="${docGroupList}" varStatus="status">
                                                            <option value="${group.groupalias}">${group.groupname}</option>
                                                        </c:forEach>    
                                                        <%
                                                            }%>
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="">Document Reference</label>
                                            <div class="controls">
                                                <div class="">
                                                    <input type="text" name="documentreference" id="docNo1" class="span10 search-doc-form-field" required/>
                                                    <input type="button" value="Add" id="add_another_criteria" title="Add another criteria" class="btn btn-small btn-info pull-right"/>                        
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="injectCriteria">

                                </div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="">Document Date (From)</label>
                                            <div class="controls">
                                                <div class="">
                                                    <!--<input type="date" id="adv_from_date" name="adv_from_date" class="span10 search-doc-form-field" onkeydown="return false">-->
                                                    <!--<input type="text" placeholder="DD-MM-YYYY" onfocus="(this.type='date')" id="adv_from_date" name="adv_from_date" class="span10 search-doc-form-field" onkeydown="return false">-->
                                                    <input type="text" placeholder="DD-MM-YYYY" id="adv_from_date" name="adv_from_date" class="span10 search-doc-form-field">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <div class="control-group">
                                            <label class="control-label" for="">To</label>
                                            <div class="controls">
                                                <div class="">
                                                    <!--                                                    <input type="date" id="adv_to_date" name="adv_to_date" class="span10 search-doc-form-field" onkeydown="return false">-->
                                                    <!--<input type="text" placeholder="DD-MM-YYYY" onfocus="(this.type='date')" id="adv_to_date" name="adv_to_date" class="span10 search-doc-form-field" onkeydown="return false">-->
                                                    <input type="text" placeholder="DD-MM-YYYY" id="adv_to_date" name="adv_to_date" class="span10 search-doc-form-field">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row-fluid">
                                    <div class="span6">
                                        <input type="button" value="Get Document" id="advsearchDocument" class="btn btn-purple">
                                        <input type="button" value="Clear Criteria" id="advclearcriteriabtn" class="btn btn-success">
                                        <input type="button" value="Close" id="advsearchclose" class="btn btn-pink">
                                    </div>
                                    <div class="span6">
                                        <input type="button" value="Download All Document" id="advsearchdownloadall" onclick="downloadMultipleDoc();
                                                saveMultipleDoc();" class="btn btn-danger align-right" style="display: none;">
                                    </div>
                                </div><br>
                                <div style="display: none;" id="myOrderDocumentTableDivId">
                                    <div class="row-fluid table-responsive">
                                        <div class="span12">
                                            <table id="Search_document_table" class="table table-striped table-bordered table-hover">
                                                <thead>
                                                <th>S.No.</th>
                                                <th>Document Number</th>
                                                <th>Document Name</th>
                                                <th>Document Type</th>
                                                <th>Document Date</th>
                                                <th></th>
                                                <th></th>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div><!--/.main-content-->
</div><!--/.main-container-->        

<script type="text/javascript">
    window.jQuery || document.write("<script src='js/jquery-2.0.3.min.js'>" + "<" + "/script>");
</script>			
<script src="js/bootstrap.min.js"></script> 
<script src="js/jquery-ui-1.10.3.custom.min.js"></script>       
<script src="js/bootbox.min.js"></script>   
<script src="js/jquery.slimscroll.min.js"></script>     
<script src="js/ace-elements.min.js"></script>
<script src="js/ace.min.js"></script>
<script src="js/fuelux/fuelux.wizard.min.js"></script>

<script type="text/javascript">
    $(function() {
        $('.dialogs,.comments').slimScroll({
            height: '200px'
        });

    });
</script>
</body>
</html>
