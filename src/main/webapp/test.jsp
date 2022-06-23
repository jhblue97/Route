<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
    <link rel="stylesheet" type="text/css" href="http://w2ui.com/src/w2ui-1.5.min.css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://w2ui.com/src/w2ui-1.5.min.js"></script>
</head>
<body>
<script>
$(function () {
    $('#myForm').w2form({
        name   : 'myForm',
        fields : [
            { name: 'first_name', type: 'text', required: true },
            { name: 'last_name',  type: 'text', required: true },
            { name: 'comments',   type: 'text'}
        ],
        actions: {
            reset: function () {
                this.clear();
            },
            save: function () {
                this.save();
            }
        }
    });
});
</script>

     <div id="myForm" style="width: 600px"></div>
</body>
</html>

</body>
</html>