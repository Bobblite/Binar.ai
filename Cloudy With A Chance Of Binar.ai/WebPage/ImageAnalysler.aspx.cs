//using Newtonsoft.Json;
using System;
using System.Text;
using System.Text.Json;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cloudy_With_A_Chance_Of_Binar.ai.WebPage
{

    public partial class ImageAnalysler : System.Web.UI.Page
    {
        public static bool haveImage = false;
        public static bool firstUpload = true;
        public static string prevUrl;

        private static readonly HttpClient client = new HttpClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = "Binar.AI";
            
            // To allow file drop
            Page.Form.Attributes.Add("enctype", "multipart/form-data");
            Page.Form.Attributes.Add("ondrop", "return false;");

           /* if (!haveImage || string.IsNullOrEmpty(ImageViewer.ImageUrl))
            {
                ImageViewer.BorderStyle = BorderStyle.Solid;
            }
            else
            {
                ImageViewer.BorderStyle = BorderStyle.None;

            }*/
        }

        protected void Page_Unload(object sender, EventArgs e)
        {       
        }

        protected void Convert_Binary_ButtonClick(object sender, EventArgs e) 
        {
            Task.Run(async () => await ConvertBinary(sender, e)).Wait();
        }

        protected async Task ConvertBinary(object sender, EventArgs e) 
        {

            if (string.Compare(ImageUrlHiddenField.Value, "undefined") == 0 ||
                string.Compare(ImageUrlHiddenField2.Value, "undefined") == 0 ||
                string.Compare(ImageUrlHiddenField3.Value, "undefined") == 0 ||
                string.Compare(ImageUrlHiddenField4.Value, "undefined") == 0)
            {
                return;
            }

            // Check if image exist, encapsulate in try catch, if doesnt throw
            //string imageUrl = Server.MapPath();
            //string imageUrl2 = Server.MapPath(ImageUrlHiddenField.Value);
            //string imageUrl3 = Server.MapPath(ImageUrlHiddenField.Value);
            //string imageUrl4 = Server.MapPath(ImageUrlHiddenField.Value);

            try
            {
                string imageURLtoBase64 = ImageUrlHiddenField.Value;
                string imageURL2toBase64 = ImageUrlHiddenField2.Value;
                string imageURL3toBase64 = ImageUrlHiddenField3.Value;
                string imageURL4toBase64 = ImageUrlHiddenField4.Value;


                // Configure the POST
                var data = new Dictionary<string, string>
                {
                    { "data3", imageURLtoBase64 },
                    { "data2", imageURL2toBase64 },
                    { "data1", imageURL3toBase64 },
                    { "data0", imageURL4toBase64 }
                };

                // Serialise in JSON
                var file = JsonSerializer.Serialize(new { data3 = imageURLtoBase64, data2 = imageURL2toBase64, data1 = imageURL3toBase64, data0 = imageURL4toBase64 });

                var content = new StringContent(file, Encoding.UTF8, "application/json");
                var response = await client.PostAsync("https://g8axc5rhv3.execute-api.ap-southeast-1.amazonaws.com/beta/binarai", content);

                if (response != null)
                {
                    var resultString = response.Content.ReadAsStringAsync();
                    var checkString = resultString.Result.ToString();

                    int result = int.Parse(checkString);

                    LabelStatus.Text = result.ToString();
                }
            }
            catch (WebException ex)
            {
                LabelStatus.Text = "ERROR, image not found: " + ex.Message;

            }
        }

        protected void Upload_And_Convert(object sender, EventArgs e)
        {
           /* if (ImageUploadControl.HasFile)
            {
                // Get the file name
                string filename = Path.GetFileName(ImageUploadControl.FileName);

                // Check if the file is an image
                string extension = System.IO.Path.GetExtension(ImageUploadControl.FileName);
                // throw 
                if (!(extension == ".jpg" || extension == ".jpeg" || extension == ".png" ||
                      extension == ".JPG" || extension == ".JPEG" || extension == ".PNG"))
                {
                    LabelStatus.Text = "Select a jpg, jpeg or png image file.";
                    return;
                }

                try
                {
                    string filepath = Server.MapPath("~/Images/Temp/" + filename);
                    ImageUploadControl.SaveAs(filepath);
                    LabelStatus.Text = "File uploaded!";

                    // Allow user to upload
                    ImageViewer.ImageUrl = "~/Images/Temp/" + filename;
                    haveImage = true;

                    if (firstUpload)
                    {
                        firstUpload = false;
                        ImageViewer.BorderStyle = BorderStyle.None;
                    }

                    prevUrl = ImageViewer.ImageUrl;
                }
                catch (Exception ex)
                {
                    LabelStatus.Text = "The following error occured during browsing: " + ex.Message;
                }
            }
            else
            {
                LabelStatus.Text = "Please select a image from folder.";
            }

            if (!string.IsNullOrEmpty(ImageViewer.ImageUrl))
            {
                try
                {
                    string fileName = Path.GetFileName(ImageViewer.ImageUrl);
                    string filePath = Path.Combine(Server.MapPath("~/Images/Temp/"), fileName);
                    string folderPath = Server.MapPath("~/Images/Temp/");

                    if (ImageUploadControl.HasFile) 
                    {
                        // Delete everythign
                        foreach (string files in Directory.GetFiles(folderPath))
                        {
                            System.IO.File.Delete(files);
                        }

                        ImageUploadControl.SaveAs(filePath);
                        prevUrl = ImageViewer.ImageUrl;
                    }

                    // Allow user to upload
                    haveImage = true;
                    if (firstUpload)
                    {
                        firstUpload = false;
                        ImageViewer.BorderStyle = BorderStyle.None;
                    }

                    prevUrl = ImageViewer.ImageUrl;
                }
                catch (Exception ex)
                {
                    LabelStatus.Text = "The following error occured during browsing: " + ex.Message;
                }
            }*/
        }
    }
}