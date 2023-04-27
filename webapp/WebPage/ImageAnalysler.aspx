<%@ Page Language="C#" MaintainScrollPositionOnPostBack="true" AutoEventWireup="true" CodeBehind="ImageAnalysler.aspx.cs" Inherits="Cloudy_With_A_Chance_Of_Binar.ai.WebPage.ImageAnalysler" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title padding-left="20px">Binar.AI</title>
    <link rel="stylesheet" type="text/css" href="../CSSFiles/ImageViewer.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="~/Scripts/drawing.js"></script>
    <script>
        window.onunload = function ()
        {
            localStorage.clear();
        }

        <%--function sendPicture()
        {
            var fileUploader = document.getElementById("<%= ImageUploadControl.ClientID %>");
            if (!fileUploader || !fileUploader.files || fileUploader.files.length <= 0) {
                console.log("Empty");
                return;
            }
            else
            {
                var status = document.getElementById("<%= LabelStatus.ClientID %>")

                var file = fileUploader.files[0];
                var filename = file.name;
                var fileExtension = filename.substring(filename, lastIndexOf('.') + 1);
                if (/(PNG|png|jpg|JPG|JPEG|jpeg)$/i.test(fileExtension))
                {
                    var image = document.getElementById("<%= ImageViewer.ClientID %>")

                    image.src = file.name;
                    status.innerText = "Passed";
                }
                else
                {
                    status.innerText = "Failed images"
                }
            }
        }

       
        function handleDragOver(event) {
            event.preventDefault();
        }

        function handleDragEnter(event) {
            event.preventDefault();
        }--%>

        var canvas;
        var canvas2;
        var canvas3;
        var canvas4;

        var hf;
        var hf2;
        var hf3;
        var hf4;

        var context;
        var context2;
        var context3;
        var context4;

        var drawing = false;
        var drawing2 = false;
        var drawing3 = false;
        var drawing4 = false;

        var drawingData = {};
        var canvasIndices = {};

        $(document).ready(function () {
            canvas = document.getElementById("canvas");
            hf = document.getElementById("<%= ImageUrlHiddenField.ClientID %>");
            context = canvas.getContext("2d");

            canvas2 = document.getElementById("canvas2");
            hf2 = document.getElementById("<%= ImageUrlHiddenField2.ClientID %>");
            context2 = canvas2.getContext("2d");

            canvas3 = document.getElementById("canvas3");
            hf3 = document.getElementById("<%= ImageUrlHiddenField3.ClientID %>");
            context3 = canvas3.getContext("2d");

            canvas4 = document.getElementById("canvas4");
            hf4 = document.getElementById("<%= ImageUrlHiddenField4.ClientID %>");
            context4 = canvas4.getContext("2d");


            canvas.addEventListener("mousedown", startDrawing);
            canvas.addEventListener("mousemove", draw);
            canvas.addEventListener("mouseup", stopDrawing);

            canvas2.addEventListener("mousedown", startDrawing2);
            canvas2.addEventListener("mousemove", draw2);
            canvas2.addEventListener("mouseup", stopDrawing2);

            canvas3.addEventListener("mousedown", startDrawing3);
            canvas3.addEventListener("mousemove", draw3);
            canvas3.addEventListener("mouseup", stopDrawing3);

            canvas4.addEventListener("mousedown", startDrawing4);
            canvas4.addEventListener("mousemove", draw4);
            canvas4.addEventListener("mouseup", stopDrawing4);
        });

        const getBase64StringFromDataURL = (dataURL) => dataURL.replace('data:', '').replace(/^.+,/, '');

        // Canvas 1

        function startDrawing(e) {
            drawing = true;
            context.beginPath();
            context.moveTo(e.pageX - canvas.offsetLeft, e.pageY - canvas.offsetTop);
        }

        function draw(e) {
            if (drawing) {
                context.lineTo(e.pageX - canvas.offsetLeft, e.pageY - canvas.offsetTop);
                context.stroke();
            }
        }

        function stopDrawing() {
            drawing = false;
            saveDrawingData(1, getBase64StringFromDataURL(canvas.toDataURL()));
        }

        // For canvas 2

        function startDrawing2(e) {
            drawing2 = true;
            context2.beginPath();
            context2.moveTo(e.pageX - canvas2.offsetLeft, e.pageY - canvas2.offsetTop);
        }

        function draw2(e) {
            if (drawing2) {
                context2.lineTo(e.pageX - canvas2.offsetLeft, e.pageY - canvas2.offsetTop);
                context2.stroke();
            }
        }

        function stopDrawing2() {
            drawing2 = false;
            saveDrawingData(2, getBase64StringFromDataURL(canvas2.toDataURL()));
        }

        // Canvas 3

        function startDrawing3(e) {
            drawing3 = true;
            context3.beginPath();
            context3.moveTo(e.pageX - canvas3.offsetLeft, e.pageY - canvas3 .offsetTop);
        }

        function draw3(e) {
            if (drawing3) {
                context3.lineTo(e.pageX - canvas3.offsetLeft, e.pageY - canvas3.offsetTop);
                context3.stroke();
            }
        }

        function stopDrawing3() {
            drawing3 = false;
            saveDrawingData(3, getBase64StringFromDataURL(canvas3.toDataURL()));
        }

        // Canvas 4

        function startDrawing4(e) {
            drawing4 = true;
            context4.beginPath();
            context4.moveTo(e.pageX - canvas4.offsetLeft, e.pageY - canvas4.offsetTop);
        }

        function draw4(e) {
            if (drawing4) {
                context4.lineTo(e.pageX - canvas4.offsetLeft, e.pageY - canvas4.offsetTop);
                context4.stroke();
            }
        }

        function stopDrawing4() {
            drawing4 = false;
            saveDrawingData(4, getBase64StringFromDataURL(canvas4.toDataURL()));
        }

        function clearCanvas() {
            context.clearRect(0, 0, canvas.width, canvas.height);
            context2.clearRect(0, 0, canvas2.width, canvas2.height);
            context3.clearRect(0, 0, canvas3.width, canvas3.height);
            context4.clearRect(0, 0, canvas4.width, canvas4.height);
            drawingData = {};
            canvasIndices = {};
        }

        // Save drawing data - for future use case
        function saveDrawingData(canvasNumber, data) {
            drawingData[canvasNumber - 1] = data;
            canvasIndices[canvasNumber - 1] = canvasNumber - 1;

            hf.value = drawingData[0];
            hf2.value = drawingData[1];
            hf3.value = drawingData[2];
            hf4.value = drawingData[3];
        }

        function convertBinary() {
            // send data to cloud
            var label = document.getElementById("NumberDecimal");

            const data = {
                data3: drawingData[0],
                data2: drawingData[1],
                data1: drawingData[2],
                data0: drawingData[3]
            };

            // check if indices and drawing data have length of 4
            if (Object.keys(drawingData).length == 4 && Object.keys(canvasIndices).length == 4)
            {
                var proxyUrl = 'https://cors-anywhere.herokuapp.com/';
                var url = "https://g8axc5rhv3.execute-api.ap-southeast-1.amazonaws.com/beta/binarai";

                var fullUrl = proxyUrl + url;


                var xhr = new XMLHttpRequest();
                xhr.open("POST", fullUrl, true);
                xhr.setRequestHeader("Content-Type", "application/json");

                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        console.log(xhr.responseText);
                        label.innerText = xhr.responseText;
                    }
                };

                xhr.send(data);
            }
            else
            {
                label.innerText = "Requires 4 inputs. Clearing entries... Please reinput 4 values"
                context.clearRect(0, 0, canvas.width, canvas.height);
                context2.clearRect(0, 0, canvas2.width, canvas2.height);
                context3.clearRect(0, 0, canvas3.width, canvas3.height);
                context4.clearRect(0, 0, canvas4.width, canvas4.height);
                drawingData = {};
                canvasIndices = {};
            }
        }

    </script>
</head>
<body>
    <form id="ImageForm" runat="server" enctype="multipart/form-data">        
        <header>Binar.AI</header>

            <asp:HiddenField runat="server" ID="ImageUrlHiddenField" />
            <asp:HiddenField runat="server" ID="ImageUrlHiddenField2" />
            <asp:HiddenField runat="server" ID="ImageUrlHiddenField3" />
            <asp:HiddenField runat="server" ID="ImageUrlHiddenField4" />
            <div id="dropzone" class="containerCSS">
                <canvas id="canvas" class="ImageViewerCenteredCSS" width="100" height="100" style="background-color:white;"></canvas>
                <canvas id="canvas2" class="ImageViewerCenteredCSS" width="100" height="100" style="background-color:white;"></canvas>
                <canvas id="canvas3" class="ImageViewerCenteredCSS" width="100" height="100" style="background-color:white;"></canvas>
                <canvas id="canvas4" class="ImageViewerCenteredCSS" width="100" height="100" style="background-color:white;"></canvas>
                

               <%-- <asp:Image ID="ImageViewer" runat="server" CssClass="ImageViewerCenteredCSS" 
                    BorderStyle="Dotted" Width="400px" Height="100px" />--%>

                <%--<asp:LinkButton ID="myLinkButton" runat="server" OnClick="ImageViewer1_Picked" AutoPostBack="false">
                    <asp:Image ID="Image1" runat="server" CssClass="ImageViewerCenteredCSS" 
                    BorderStyle="Dotted" Width="100px" Height="100px" ondrop="handleDrop(event)"
                    ondragover="handleDragOver(event)" ondragenter="handleDragEnter(event)" />
                </asp:LinkButton>--%>
            </div><br />

            <%--<asp:FileUpload ID="ImageUploadControl" runat="server" CssClass="CenterAlignedCSS" ></asp:FileUpload><br/>
            <asp:Button ID="ImageUploadButton" runat="server"  CssClass="CenterAlignedCSS"  Color = "black" Text="Upload Image to the block" AutoPostBack="false" OnClick="Upload_And_Convert" ></asp:Button>--%>
            <asp:Button ID="ClearButton" runat="server"  CssClass="CenterAlignedCSS" BackColor="#0F0700" Text="Clear"  AutoPostBack="false" OnClientClick="clearCanvas(); return false;"></asp:Button>
            <asp:Button ID="ConvertBinaryButton" runat="server"  CssClass="CenterAlignedCSS" BackColor="#0F0700" Text="Convert Binary" OnClick="Convert_Binary_ButtonClick" AutoPostBack="false"></asp:Button>
            <asp:Label ID="LabelStatus" runat="server" Text="" Font-Underline="true" CssClass="CenterAlignedCSS"/><br />
            <asp:Label ID="DecimalToBinaryTitle" runat="server" Text="Binary To Decimal" Font-Underline="true" CssClass="CenterAlignedCSS"/><br />
            <asp:Label ID="NumberDecimal" runat="server" Text="0" CssClass="CenterAlignedCSS" /><br />



         <footer id="footer">

                <div class="container TMP">
                  <p class="p3 TMP">
                    <b> some credits </b>
                    <br>
                    This site uses subway cookies.
                  </p>
                </div>
            </footer>
    </form>
</body>
</html>
