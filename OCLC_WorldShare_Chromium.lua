-- About OCLC_WorldShare_Chromium.lua
--
-- Author: Bill Jones III, SUNY Geneseo, jonesw@geneseo.edu
-- OCLC_WorldShare_Chromium.lua is the Chromium version of the main form for the OCLC_WorldShare by Tim Bowersox.
-- Github Repository:  https://github.com/Hypolymer/OCLC_WorldShare_Chromium
--
-- There is a config file that is associated with this Addon that allows you to store your OCLC WorldShare login information
-- Alternatively, you can store your OCLC WorldShare login information may in the LocalSettings.xml file 
-- by editing the Addon settings in ILLiad under System > Manage Addons
--
--
-- Addon Process:
-- This Addon will automatically open the OCLC WorldShare login page in a main form tab named 
-- Once the OCLC WorldShare login page is loaded, type in your OCLC Symbol and select your Library (or press the Enter key)
-- Next, click on the Unlock icon in the Addon ribbon labeled "Set OCLC Login"
-- You should now be at the OCLC WorldShare interface!
--
--
-- Old WorldShare URL:  https://geneseo.share.worldcat.org/wms/cmnd/
-- New WorldShare URL:  https://www.oclc.org/apps/oclc/welcome?service=wms&amp;inst_type=wayf

local settings = {};
settings.OCLC_WorldShareURL = GetSetting("OCLC_WorldShareURL");
settings.Username = GetSetting("Username");
settings.Password = GetSetting("Password");

local interfaceMngr = nil;
local cbrowser = nil;
local Worldcat_ChromiumSearchForm = {};
Worldcat_ChromiumSearchForm.Form = nil;
cbrowser = nil;
Worldcat_ChromiumSearchForm.RibbonPage = nil;

function Init()
	interfaceMngr = GetInterfaceManager();
	--Create Form
	Worldcat_ChromiumSearchForm.Form = interfaceMngr:CreateForm("OCLC WorldShare", "Script");
	-- Create Chromium browser
	cbrowser = Worldcat_ChromiumSearchForm.Form:CreateBrowser("OCLC WorldShare", "OCLC WorldShare", "OCLC WorldShare", "Chromium");
	-- Hide the text label
	cbrowser.TextVisible = false;

	-- Since we didn't create a ribbon explicitly before creating our browser, it will have created one using the name we passed the CreateBrowser method.  We can retrieve that one and add our buttons to it.
	Worldcat_ChromiumSearchForm.RibbonPage = Worldcat_ChromiumSearchForm.Form:GetRibbonPage("OCLC WorldShare");
	   
	-- Here we are adding a new button to the ribbon
	Worldcat_ChromiumSearchForm.RibbonPage:CreateButton("Home", GetClientImage("Home32"), "Home", "OCLC WorldShare");
	Worldcat_ChromiumSearchForm.RibbonPage:CreateButton("Set OCLC Login", GetClientImage("Unlock32"), "WorldShareLogin", "OCLC WorldShare");
	Worldcat_ChromiumSearchForm.RibbonPage:CreateButton("Print", GetClientImage("Print32"), "PrintPage", "OCLC WorldShare");		
		
	Worldcat_ChromiumSearchForm.Form:Show();
    
	-- Navigate to OCLC WorldShare URL
	Home();
end


function Home()
	cbrowser:Navigate(settings.OCLC_WorldShareURL);
end


function WorldShareLogin()	
	
	cbrowser:ExecuteScript("document.getElementById('username').value = '" .. settings.Username .. "'");
	cbrowser:ExecuteScript("document.getElementById('password').value = '" .. settings.Password .. "'");	
	cbrowser:ExecuteScript("document.forms['signin'].submit()");

end

function PrintPage()	
cbrowser:ExecuteScript("window.print()")
end
