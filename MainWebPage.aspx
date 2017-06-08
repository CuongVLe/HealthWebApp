<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainWebPage.aspx.cs" Inherits="WebHealthCareApplication.MainWebPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HealthCare Web App</title>
    <link id="lnkCSS" href="~/Content/StyleSheet.css" rel="stylesheet" type="text/css" runat="server"/>
    <script type="text/javascript">
        function check(obj) {
            if (obj.value.trim() != "") {
                document.getElementById("Button1").disabled = false;
            }
            else {
                document.getElementById("Button1").disabled = true;
            }
        }
    </script>
</head>

<body>
    <div>
    <form method="POST" runat="server"> 
        <div>
            <!--
                Text input field for the patient/account ID that the user will enter to varify
                The patient is a valid ID in our Patient Database.
             -->
            <label for="patientID">Patient Account</label>
            <asp:TextBox ID="TextBox1" name="patientID" runat="server" onblur="return check(this);"></asp:TextBox>
            <!--
                Upon clicking on the Search button, a sql query will run to validate if the ID entered is a valid one in the Patient database.
                Upon clicking on the Search button, the Search button will be hidden and a Reset button will be visibile.
                The Reset button is to reset the fields and set the Search button back to be visible.
            -->
            <asp:Button ID="Button1" runat="server" Text="Search" OnClick="ChangeCSS" CommandArgument="StyleSheet2.css" CssClass="hideBtn" disabled="true"/>
            <asp:Button ID="Button2" runat="server" Text="Reset" OnClick="ChangeCSS" CommandArgument="StyleSheet.css" CssClass="visibleBtn"/>
            <br/>
            <br/>

            <!--
                Upon clicking the Search button and the Patient ID was validated, the questionnaire for the patient will be visable.
                Upon clicking the Submit button, the response captured will stored in the PatQuestions database.
            -->
            <label for="DropDownList1" class="visibility">Does Patient have limited English Proficiency?</label>
            <asp:DropDownList ID="DropDownList1" runat="server" class="visibility">
                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
            </asp:DropDownList>
            <br/>
            <label for="CheckBoxList1" class="visibility">Is the patient a (mark all that apply)</label>
            <asp:CheckBoxList ID="CheckBoxList1" runat="server" class="visibility">
                <asp:ListItem Text="Veteran" Value="Veteran"></asp:ListItem>
                <asp:ListItem Text="Homeless" Value="Homeless"></asp:ListItem>
                <asp:ListItem Text="Migrant Worker" Value="Migrant"></asp:ListItem>
                <asp:ListItem Text="Seasonal Worker" Value="Seasonal"></asp:ListItem>
                <asp:ListItem Text="Disabled" Value="Disabled"></asp:ListItem>
            </asp:CheckBoxList>
            <label for="CheckBoxList2" class="visibility">Is patient diagnosed with any of the following conditions (choose all that apply)</label>
            <asp:CheckBoxList ID="CheckBoxList2" runat="server" class="visibility">
                <asp:ListItem Text="Depression" Value="Depression"></asp:ListItem>
                <asp:ListItem Text="Severe Depression" Value="Severe"></asp:ListItem>
                <asp:ListItem Text="Anxiety" Value="Anxiety"></asp:ListItem>
                <asp:ListItem Text="Substance" Value="Substance Use Disorder"></asp:ListItem>
                <asp:ListItem Text="Asthma" Value="Asthma"></asp:ListItem>
                <asp:ListItem Text="Allergies" Value="Allergies"></asp:ListItem>
                <asp:ListItem Text="Eczema" Value="Eczema"></asp:ListItem>
                <asp:ListItem Text="Obesity" Value="Obesity"></asp:ListItem>
                <asp:ListItem Text="BMI Higher than 34.9" Value="BMI"></asp:ListItem>
                <asp:ListItem Text="A1c > 10" Value="A1c"></asp:ListItem>
            </asp:CheckBoxList>
            <label for="DropDownList2" class="visibility">Has patient visited ER > 5 times in last calendar year?</label>
            <asp:DropDownList ID="DropDownList2" runat="server" class="visibility">
                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
            </asp:DropDownList>
            <br/>
            <label for="DropDownList3" class="visibility">Does patient have a reading disability?</label>
            <asp:DropDownList ID="DropDownList3" runat="server" class="visibility">
                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
            </asp:DropDownList>
            <br/>
            <label for="DropDownList4" class="visibility">Is patient a foster child?</label>
            <asp:DropDownList ID="DropDownList4" runat="server" class="visibility">
                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
            </asp:DropDownList>
            <br/>
            <asp:Button ID="Button3" runat="server" Text="Submit" OnClick="ChangeCSS" CommandArgument="StyleSheet.css" CssClass="visibleBtn"/>
            <br/>
            <br/>
            
            <!--
                SQL Database connection to local database: HealthCareDB (~/App_Data/PaitentDB.mdf).

                On Search button click, the SqlDataSource1 will query the Patient table to obtain
                the patient's detail such as: First name, Middle initial name, date of birth, and PCP id and display
                the information in a gridview.

                On Submit button click, the SqlDataSource2 will query the PatQuestions table to verify the patient ID is in the
                database, selecting the columns to store the questionnaires and insert the information selected by the user.
             -->

            <!-- TO DO

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                connectionString="<%$ ConnectionStrings:HealthCareDB %>" 
                SelectCommand="SELECT AccountID,ufname,uminitial,ptDOB,PCP FROM Patient WHERE AccountID = @PatientID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="PatientID" Type="Int32" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>
            
            <asp:GridView ID="GridView1" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
            RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000"
            runat="server" AutoGenerateColumns="false" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="CustomerId" HeaderText="Customer Id" ItemStyle-Width="150px" />
                <asp:BoundField DataField="ContactName" HeaderText="Contact Name" ItemStyle-Width="150px" />
                <asp:BoundField DataField="City" HeaderText="City" ItemStyle-Width="100px" />
                <asp:BoundField DataField="Country" HeaderText="Country" ItemStyle-Width="100px" />
            </Columns>
            </asp:GridView>

                
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                connectionString="<%$ ConnectionStrings:HealthCareDB %>"
                SelectCommand="SELECT PatStatus, PatDiag, VistedLastYr, ReadDis, FosterChild, LimitedEng FROM PatQuestions WHERE PatID = @PatientID
                InsertCommand="INSERT INTO PatQuestions (PatStatus, PatDiag, VistedLastYr, ReadDis, FosterChild, LimitedEng)
                               VALUES (@PatientStatus, @PatientDiagnosed, @VistedWithinYear, @ReadingDisability, @FosterChild, @LimitedEnglish)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="PatientID" Type="Int32" DefaultValue="0" />
                </SelectParameters>
                <insertparameters>
                    <asp:formparameter name="PatientStatus" formfield="CompanyNameBox" />
                    <asp:formparameter name="PatientDiagnosed"  formfield="PhoneBox" />
                    <asp:formparameter name="VistedWithinYear" formfield="CompanyNameBox" />
                    <asp:formparameter name="ReadingDisability"  formfield="PhoneBox" />
                    <asp:formparameter name="FosterChild" formfield="CompanyNameBox" />
                    <asp:formparameter name="LimitedEnglish"  formfield="PhoneBox" />
                </insertparameters>
            </asp:SqlDataSource>

            -->
        </div>
    </form>
    </div>
</body>
</html>
