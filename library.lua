_G["Theme"] = {
    ["Window_Border"] = Color3.fromRGB(166, 94, 0),
    ["Close_Button"] = Color3.fromRGB(175, 100, 20),

    ["Section_Title"] = Color3.fromRGB(210, 210, 210),
    ["Section_Background"] = Color3.fromRGB(0, 0, 0),

    ["Item_Name_Color"] = Color3.fromRGB(255, 255, 255),

    ["Button"] = Color3.fromRGB(166, 94, 0),

    ["Toggle"] = Color3.fromRGB(166, 94, 0),

    ["Color_Picker"] = Color3.fromRGB(166, 94, 0),
    ["Color_Picker_Selector_Frame"] = Color3.fromRGB(166, 94, 0),

    ["Slider_Bar"] = Color3.fromRGB(166, 94, 0),
    ["Slider_Bob"] = Color3.fromRGB(255, 255, 255),
    ["Slider_Value"] = Color3.fromRGB(160, 0, 255),

    ["Keybind_Border"] = Color3.fromRGB(166, 94, 0),

    ["Dropdown_Border"] = Color3.fromRGB(166, 94, 0),
    ["Dropdown_Arrow"] = Color3.fromRGB(255, 255, 255),
    ["Dropdown_Main_Option"] = Color3.fromRGB(255, 213, 153),
    ["Dropdown_Options"] = Color3.fromRGB(255, 255, 255),
}

--LUA FUNCTIONS
local clamp = math.clamp
local round = math.round
local abs = math.abs
local random = math.random
local floor = math.floor

local u2 = UDim2.new
local new = Instance.new
local RGB = Color3.fromRGB
local HSV = Color3.fromHSV
local tween = TweenInfo.new
local stringsub = string.sub

local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%'
local length = 15

math.randomseed(os.time())

local charTable = {}
for c in chars:gmatch "." do
    table.insert(charTable, c)
end

local function newstring()
    local a = ''
    for i = 1, length do
        a = a .. charTable[random(1, #charTable)]
    end
    return a
end

local Library = {}

function Library:NewWindow()
    local DESTROY_GUI = false

    local project_name = newstring()
    local Player = game:GetService("Players").LocalPlayer
    local Mouse = Player:GetMouse()
    local TS = game:service("TweenService")
    local UIS = game:service("UserInputService")
    local ColorModule = loadstring(game:HttpGet("https://gist.githubusercontent.com/ao-0/2b1d817a289af992d5fc97b93f180ee8/raw/9b6fd5ccfc4ff6308f8b918d209a4dae27025843/gistfile1.txt"))()

    local UI = new("ScreenGui")
    syn.protect_gui(UI)
    
    local MainWindow = new("Frame")
    local TopBar = new("Frame")
    local ProjectTitle = new("TextLabel")
    local CloseButton = new("ImageButton")
    local MinimizeButton = new("ImageButton")

    local Click = new('Sound')
    Click.Parent = game.CoreGui
    Click.Name = "click"
    Click.SoundId = "rbxassetid://1238528678"
    Click.Volume = 2

    local Categories = new("Frame")

    local PageBar = new("Frame")
    local PageListLayout = new("UIListLayout")
    local Credits = new("TextLabel")

    UI.Name = project_name
    UI.Parent = game.CoreGui
    UI.ZIndexBehavior = Enum.ZIndexBehavior.Global
    UI.ResetOnSpawn = false

    MainWindow.Name = "MainWindow"
    MainWindow.Parent = UI
    MainWindow.BackgroundColor3 = RGB(20, 20, 20)
    MainWindow.BackgroundTransparency = 0.1
    MainWindow.BorderColor3 = _G["Theme"]["Window_Border"]
    MainWindow.ClipsDescendants = false
    MainWindow.Position = u2(0.17239584, 0, 0.152777776, 0)
    MainWindow.Size = u2(0, 800, 0, 500)
    MainWindow.Active = true
    MainWindow.Draggable = true

    local toggled_ui = false
    local previous = MainWindow.AbsolutePosition

    local function TOGGLE_UI()
        toggled_ui = not toggled_ui
        if toggled_ui then
            previous = MainWindow.AbsolutePosition
            TS:Create(MainWindow, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = u2(0, previous.X, 0, workspace.CurrentCamera.ViewportSize.Y + 10)}):Play()
        else
            TS:Create(MainWindow, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = u2(0, previous.X, 0, previous.Y)}):Play()
        end
    end

    TopBar.Name = "TopBar"
    TopBar.Parent = MainWindow
    TopBar.BackgroundColor3 = RGB(30, 30, 30)
    TopBar.BorderColor3 = RGB(255, 255, 255)
    TopBar.BorderSizePixel = 0
    TopBar.ZIndex = 3
    TopBar.Size = u2(1, 0, 0, 40)

    ProjectTitle.Name = "ProjectTitle"
    ProjectTitle.Parent = TopBar
    ProjectTitle.BackgroundColor3 = RGB(255, 255, 255)
    ProjectTitle.BackgroundTransparency = 1.000
    ProjectTitle.Position = u2(0, 10, 0, 0)
    ProjectTitle.Size = u2(0.5, 0, 1, 0)
    ProjectTitle.Font = Enum.Font.Gotham
    ProjectTitle.RichText = true
    ProjectTitle.ZIndex = 4
    ProjectTitle.Text = _G["UI_Info"]["Project_Title"]
    ProjectTitle.TextColor3 = RGB(255, 255, 255)
    ProjectTitle.TextSize = 25.000
    ProjectTitle.TextWrapped = true
    ProjectTitle.TextXAlignment = Enum.TextXAlignment.Left

    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundColor3 = RGB(255, 255, 255)
    CloseButton.BackgroundTransparency = 1.000
    CloseButton.Position = u2(1, -33, 0.5, -11)
    CloseButton.Size = u2(0, 22, 0, 22)
    CloseButton.AutoButtonColor = false
    CloseButton.ZIndex = 4
    CloseButton.Image = "rbxassetid://6814382218"
    CloseButton.ImageColor3 = _G["Theme"]["Close_Button"]

    CloseButton.MouseEnter:Connect(function()
        TS:Create(CloseButton, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageTransparency = 0.15}):Play()
    end)

    CloseButton.MouseLeave:Connect(function()
        TS:Create(CloseButton, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    end)

    CloseButton.MouseButton1Click:Connect(function()
        TOGGLE_UI()
    end)

    PageBar.Name = "PageBar"
    PageBar.Parent = MainWindow
    PageBar.BackgroundColor3 = RGB(27, 27, 27)
    PageBar.BorderColor3 = RGB(255, 255, 255)
    PageBar.BorderSizePixel = 0
    PageBar.Position = u2(0, 0, 0, 40)
    PageBar.Size = u2(0, 150, 1, -40)

    PageListLayout.Parent = PageBar
    PageListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageListLayout.Padding = UDim.new(0, 0)

    Credits.Name = "Credits"
    Credits.Parent = MainWindow
    Credits.BackgroundColor3 = RGB(255, 255, 255)
    Credits.BackgroundTransparency = 1.000
    Credits.Position = u2(0, 5, 0, 472.5)
    Credits.Size = u2(0, 10, 0, 30)
    Credits.Font = Enum.Font.Code
    Credits.Text = "By Blissful#4992"
    Credits.TextColor3 = RGB(255, 255, 255)
    Credits.TextSize = 11.000
    Credits.TextXAlignment = Enum.TextXAlignment.Left

    Categories.Name = "Categories"
    Categories.Parent = MainWindow
    Categories.BackgroundColor3 = RGB(35, 35, 35)
    Categories.BorderColor3 = RGB(255, 255, 255)
    Categories.BorderSizePixel = 0
    Categories.Position = u2(0, 150, 0, 40)
    Categories.Size = u2(1, -150, 1, -40)

    local structurer = {}

    function structurer:Toggle()
        TOGGLE_UI()
    end

    function structurer:UpdateTheme()
        ProjectTitle.Text = _G["UI_Info"]["Project_Title"]
        MainWindow.BorderColor3 = _G["Theme"]["Window_Border"]
        CloseButton.ImageColor3 = _G["Theme"]["Close_Button"]

        local t = UI:GetDescendants()
        for i = 1, #t do
            local v = t[i]
            if v.Name == "Section" then
                v.BackgroundColor3 = _G["Theme"]["Section_Background"]
                v.SectionTitle.TextColor3 = _G["Theme"]["Section_Title"]
            elseif v.Name == "Button" then
                v.Detector.BorderColor3 = _G["Theme"]["Button"]
                v.Detector.TextColor3 = _G["Theme"]["Item_Name_Color"]
            elseif v.Name == "Toggle" then
                v.ToggleName.TextColor3 = _G["Theme"]["Item_Name_Color"]
                v.Detector.BorderColor3 = _G["Theme"]["Toggle"]
            elseif v.Name == "ColorPicker" then
                v.PickerName.TextColor3 = _G["Theme"]["Item_Name_Color"]
                v.Detector.BorderColor3 = _G["Theme"]["Color_Picker"]
                v.PickerFrame.BorderColor3 = _G["Theme"]["Color_Picker_Selector_Frame"]
            elseif v.Name == "Slider" then
                v.SliderName.TextColor3 = _G["Theme"]["Item_Name_Color"]
                v.Value.TextColor3 = _G["Theme"]["Slider_Value"]
                v.Detector.Bar.BackgroundColor3 = _G["Theme"]["Slider_Bar"]
                v.Detector.Bob.BackgroundColor3 = _G["Theme"]["Slider_Bob"]
            elseif v.Name == "Keybind" then
                v.Detector.BorderColor3 = _G["Theme"]["Keybind_Border"]
                v.KeybindName.TextColor3 = _G["Theme"]["Item_Name_Color"]
            elseif v.Name == "Dropdown" then
                v.DropdownName.TextColor3 = _G["Theme"]["Item_Name_Color"]
                v.Detector.BorderColor3 = _G["Theme"]["Dropdown_Border"]
                v.Detector.TextColor3 = _G["Theme"]["Dropdown_Main_Option"]
                v.Detector.Arrow.ImageColor3 = _G["Theme"]["Dropdown_Arrow"]
            elseif v.Name == "Option" then
                v.TextColor3 = _G["Theme"]["Dropdown_Options"]
            end
        end
    end

    function structurer:Kill()
        DESTROY_GUI = true
        UI:Destroy()
        game.CoreGui:FindFirstChild(project_name):Destroy()
    end

    function structurer:NewPage(tbl, page_name)
        local CurrentPageNumber = #tbl + 1
        local page_info = {["name"] = page_name, ["idx"] = CurrentPageNumber}
        table.insert(tbl, page_info) 

        local Page = new("TextButton")
        local PageName = new("TextLabel")

        Page.Name = CurrentPageNumber
        Page.Parent = PageBar
        Page.BackgroundColor3 = RGB(10, 10, 10)
        Page.BackgroundTransparency = 0.85
        Page.BorderSizePixel = 0
        Page.Size = u2(1, 0, 0, 35)
        Page.AutoButtonColor = false
        Page.Font = Enum.Font.SourceSans
        Page.Text = ""
        Page.TextColor3 = RGB(0, 0, 0)
        Page.TextSize = 14.000

        PageName.Name = "PageName"
        PageName.Parent = Page
        PageName.BackgroundColor3 = RGB(255, 255, 255)
        PageName.BackgroundTransparency = 1.000
        PageName.BorderColor3 = RGB(255, 255, 255)
        PageName.Position = u2(0, 10, 0, 0)
        PageName.Size = u2(1, -10, 0, 35)
        PageName.Font = Enum.Font.SourceSans
        PageName.Text = page_name
        PageName.TextColor3 = RGB(255, 255, 255)
        PageName.TextSize = 16.000
        PageName.TextXAlignment = Enum.TextXAlignment.Left

        local Page_Category = new("Frame")

        local Column1 = new("Frame")
        local ColumnLayout1 = new("UIListLayout")
        local Column2 = new("Frame")
        local ColumnLayout2 = new("UIListLayout")
        local Column3 = new("Frame")
        local ColumnLayout3 = new("UIListLayout")

        Page_Category.Name = CurrentPageNumber
        Page_Category.Parent = Categories
        Page_Category.BackgroundColor3 = RGB(255, 255, 255)
        Page_Category.BackgroundTransparency = 1.000
        Page_Category.BorderColor3 = RGB(255, 255, 255)
        Page_Category.BorderSizePixel = 0
        Page_Category.Visible = false
        Page_Category.Size = u2(1, 0, 1, 0)
        Page_Category.ClipsDescendants = false

        Column1.Name = "Column1"
        Column1.Parent = Page_Category
        Column1.BackgroundColor3 = RGB(255, 255, 255)
        Column1.BackgroundTransparency = 1.000
        Column1.Size = u2(0.33, 0, 1, 0)

        ColumnLayout1.Parent = Column1
        ColumnLayout1.SortOrder = Enum.SortOrder.LayoutOrder

        Column2.Name = "Column2"
        Column2.Parent = Page_Category
        Column2.BackgroundColor3 = RGB(255, 255, 255)
        Column2.BackgroundTransparency = 1.000
        Column2.Position = u2(0.33, 1, 0, 0)
        Column2.Size = u2(0.33, 0, 1, 0)

        ColumnLayout2.Parent = Column2
        ColumnLayout2.SortOrder = Enum.SortOrder.LayoutOrder

        Column3.Name = "Column3"
        Column3.Parent = Page_Category
        Column3.BackgroundColor3 = RGB(255, 255, 255)
        Column3.BackgroundTransparency = 1.000
        Column3.Position = u2(0.666999996, 1, 0, 0)
        Column3.Size = u2(0.33, 0, 1, 0)

        ColumnLayout3.Parent = Column3
        ColumnLayout3.SortOrder = Enum.SortOrder.LayoutOrder

        Page.MouseButton1Click:Connect(function()
            local t = PageBar:GetChildren()
            for i = 1, #t do
                local v = t[i]
                if v:IsA("TextButton") then
                    if tonumber(v.Name) ~= CurrentPageNumber then
                        v.BackgroundColor3 = RGB(12, 12, 12)
                    else 
                        v.BackgroundColor3 = RGB(0, 0, 0)
                    end
                end
            end
            local t2 = Categories:GetChildren()
            for i2 = 1, #t2 do
                local v = t2[i2]
                if tonumber(v.Name) == CurrentPageNumber then
                    v.Visible = true
                else
                    v.Visible = false
                end
            end
        end)

        local pickerzindex = 1000
        local function NewPickerLayer()
            pickerzindex = pickerzindex + 1
        end

        local dropdownzindex = 10
        local function NewDropdownLayer()
            dropdownzindex = dropdownzindex + 1
        end

        local section_lib = {}
        function section_lib:NewSection(name)
            local Section = new("Frame")
            local SectionListLayout = new("UIListLayout")
            local SectionTitle = new("TextLabel")

            Section.Name = "Section"
            if Column1:FindFirstChildOfClass("Frame") == nil then
                Section.Parent = Column1
            elseif Column2:FindFirstChildOfClass("Frame") == nil then
                Section.Parent = Column2
            elseif Column3:FindFirstChildOfClass("Frame") == nil then
                Section.Parent = Column3
            else
                Section:Destroy()
            end
            Section.BackgroundColor3 = _G["Theme"]["Section_Background"]
            Section.BackgroundTransparency = 0.95
            Section.BorderSizePixel = 0
            Section.Size = u2(1, 0, 0, 30)

            SectionListLayout.Parent = Section
            SectionListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundColor3 = RGB(255, 255, 255)
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Size = u2(1, 0, 0, 30)
            SectionTitle.Font = Enum.Font.SourceSans
            SectionTitle.TextColor3 = _G["Theme"]["Section_Title"]
            SectionTitle.Text = name
            SectionTitle.TextSize = 14.000

            local function_library = {}
            function function_library:NewButton(name, CallBack)
                local Button = new("Frame")
                local Detector = new("TextButton")

                Button.Name = "Button"
                Button.Parent = Section
                Button.BackgroundColor3 = RGB(255, 255, 255)
                Button.BackgroundTransparency = 1.000
                Button.BorderSizePixel = 0
                Button.Position = u2(0, 0, 0.134468913, 0)
                Button.Size = u2(1, 0, 0, 30)

                Detector.Name = "Detector"
                Detector.Parent = Button
                Detector.BackgroundColor3 = RGB(29, 29, 29)
                Detector.BorderColor3 = _G["Theme"]["Button"]
                Detector.Position = u2(0, 10, 0.5, -10)
                Detector.Size = u2(1, -20, 0, 20)
                Detector.AutoButtonColor = false
                Detector.Font = Enum.Font.SourceSans
                Detector.Text = name
                Detector.TextColor3 = _G["Theme"]["Item_Name_Color"]
                Detector.TextSize = 14.000

                Section.Size = u2(1, 0, 0, SectionListLayout.AbsoluteContentSize.Y)

                Detector.MouseEnter:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0.3}):Play()
                end)
            
                Detector.MouseLeave:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                end)

                Detector.MouseButton1Click:Connect(function()
                    -- Click:Play()
                    CallBack()
                end)

                local button_function_library = {}
                function button_function_library:Fire(times)
                    local n = times or 1
                    for i = 1, n do
                        CallBack()
                    end
                end

                return button_function_library
            end
            function function_library:NewToggle(name, CallBack, info)
                local Toggle = new("Frame")
                local ToggleName = new("TextLabel")
                local Detector = new("TextButton")

                Toggle.Name = "Toggle"
                Toggle.Parent = Section
                Toggle.BackgroundColor3 = RGB(255, 255, 255)
                Toggle.BackgroundTransparency = 1.000
                Toggle.BorderSizePixel = 0
                Toggle.Position = u2(0, 0, 0.134468913, 0)
                Toggle.Size = u2(1, 0, 0, 30)

                ToggleName.Name = "ToggleName"
                ToggleName.Parent = Toggle
                ToggleName.BackgroundColor3 = RGB(255, 255, 255)
                ToggleName.BackgroundTransparency = 1.000
                ToggleName.Position = u2(0, 10, 0, 0)
                ToggleName.Size = u2(0, 2, 1, 0)
                ToggleName.Font = Enum.Font.SourceSans
                ToggleName.TextColor3 = _G["Theme"]["Item_Name_Color"]
                ToggleName.Text = name
                ToggleName.TextSize = 15.000
                ToggleName.TextXAlignment = Enum.TextXAlignment.Left

                Detector.Name = "Detector"
                Detector.Parent = Toggle
                Detector.BackgroundColor3 = RGB(29, 29, 29)
                Detector.BorderColor3 = _G["Theme"]["Toggle"]
                Detector.Position = u2(1, -28, 0.5, -9)
                Detector.Size = u2(0, 18, 0, 18)
                Detector.AutoButtonColor = false
                Detector.Font = Enum.Font.Code
                Detector.Text = ""
                Detector.TextColor3 = RGB(255, 255, 255)
                Detector.TextSize = 13.000

                local default = info.default or false

                local bool = default
                if bool == true then
                    Detector.Text = "X"
                else
                    Detector.Text = ""
                end

                Section.Size = u2(1, 0, 0, SectionListLayout.AbsoluteContentSize.Y)

                Detector.MouseEnter:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0.3}):Play()
                end)
            
                Detector.MouseLeave:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                end)

                local function Toggle()
                    bool = not bool
                    if bool == true then
                        Detector.Text = "X"
                    else
                        Detector.Text = ""
                    end
                    CallBack(bool)
                end

                Detector.MouseButton1Click:Connect(function()
                    -- Click:Play()
                    Toggle()
                end)
                local current_bind = info.keybind or nil

                local c
                c = UIS.InputBegan:Connect(function(input)
                    if DESTROY_GUI then
                        c:Disconnect()
                    elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == current_bind then
                        -- Click:Play()
                        Toggle()
                    end
                end)

                local toggle_function_library = {}
                function toggle_function_library:UpdateKeybind(newbind)
                    current_bind = newbind
                end

                function toggle_function_library:Toggle()
                    Toggle()
                end

                return toggle_function_library
            end
            local function MouseNotIn(obj)
                if (Mouse.X < obj.AbsolutePosition.X or Mouse.X > obj.AbsolutePosition.X + obj.AbsoluteSize.X) or (Mouse.Y < obj.AbsolutePosition.Y or Mouse.Y > obj.AbsolutePosition.Y + obj.AbsoluteSize.Y) then
                    return true
                end
                return false
            end
            function function_library:NewColorPicker(name, CallBack, info)
                local ColorPicker = new("Frame")
                local PickerName = new("TextLabel")
                local Detector = new("ImageButton")
                local PickerFrame = new("Frame")
                local HSVBox = new("ImageButton")
                local Cursor = new("Frame")
                local HUEPicker = new("ImageButton")
                local HUEGradient = new("UIGradient")
                local Indicator = new("Frame")
                local Value1 = new("TextBox")
                local Value2 = new("TextBox")
                local Value3 = new("TextBox")
                local CopyValues = new("TextButton")

                ColorPicker.Name = "ColorPicker"
                ColorPicker.Parent = Section
                ColorPicker.BackgroundColor3 = RGB(255, 255, 255)
                ColorPicker.BackgroundTransparency = 1.000
                ColorPicker.BorderSizePixel = 0
                ColorPicker.Position = u2(0, 0, 0.134468913, 0)
                ColorPicker.Size = u2(1, 0, 0, 30)

                PickerName.Name = "PickerName"
                PickerName.Parent = ColorPicker
                PickerName.BackgroundColor3 = RGB(255, 255, 255)
                PickerName.BackgroundTransparency = 1.000
                PickerName.Position = u2(0, 10, 0, 0)
                PickerName.Size = u2(0, 2, 1, 0)
                PickerName.Font = Enum.Font.SourceSans
                PickerName.TextColor3 = _G["Theme"]["Item_Name_Color"]
                PickerName.TextSize = 15.000
                PickerName.Text = name
                PickerName.TextXAlignment = Enum.TextXAlignment.Left

                Detector.Name = "Detector"
                Detector.Parent = ColorPicker
                Detector.BackgroundColor3 = info.default or RGB(255, 255, 255)
                Detector.BorderColor3 = _G["Theme"]["Color_Picker"]
                Detector.BackgroundTransparency = 0
                Detector.BorderSizePixel = 1
                Detector.Position = u2(1, -34, 0.5, -6)
                Detector.ImageTransparency = 1
                Detector.Size = u2(0, 25, 0, 12)
                Detector.ZIndex = 2
                Detector.AutoButtonColor = false

                Detector.MouseEnter:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0.3}):Play()
                end)
            
                Detector.MouseLeave:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                end)

                Section.Size = u2(1, 0, 0, SectionListLayout.AbsoluteContentSize.Y)

                NewPickerLayer()
                PickerFrame.Name = "PickerFrame"
                PickerFrame.Parent = ColorPicker
                PickerFrame.BackgroundColor3 = RGB(32, 32, 32)
                PickerFrame.BorderColor3 = _G["Theme"]["Color_Picker_Selector_Frame"]
                PickerFrame.ClipsDescendants = true
                PickerFrame.Visible = false
                PickerFrame.ZIndex = pickerzindex
                PickerFrame.Position = u2(1, -150, 1, 0)
                PickerFrame.Size = u2(0, 140, 0, 175)

                NewPickerLayer()
                HSVBox.Name = "HSVBox"
                HSVBox.Parent = PickerFrame
                HSVBox.BackgroundColor3 = RGB(255, 255, 255)
                HSVBox.BorderColor3 = RGB(28, 28, 28)
                HSVBox.Position = u2(0, 5, 0, 5)
                HSVBox.Size = u2(0, 115, 0, 115)
                HSVBox.ZIndex = pickerzindex
                HSVBox.AutoButtonColor = false
                HSVBox.Image = "rbxassetid://4155801252"

                HUEPicker.Name = "HUEPicker"
                HUEPicker.Parent = PickerFrame
                HUEPicker.BackgroundColor3 = RGB(255, 255, 255)
                HUEPicker.BorderColor3 = RGB(28, 28, 28)
                HUEPicker.Position = u2(1, -15, 0, 5)
                HUEPicker.Size = u2(0, 10, 0, 115)
                HUEPicker.Rotation = 0
                HUEPicker.ZIndex = pickerzindex
                HUEPicker.AutoButtonColor = false
                HUEPicker.ImageTransparency = 1.000

                NewPickerLayer()
                Value1.Name = "Value1"
                Value1.Parent = PickerFrame
                Value1.BackgroundColor3 = RGB(28, 28, 28)
                Value1.BorderColor3 = RGB(25, 25, 25)
                Value1.Position = u2(0, 5, 1, -50)
                Value1.Size = u2(0.330000013, -10, 0, 20)
                Value1.ClearTextOnFocus = false
                Value1.Font = Enum.Font.SourceSans
                Value1.PlaceholderColor3 = RGB(255, 255, 255)
                Value1.Text = ""
                Value1.ZIndex = pickerzindex
                Value1.TextColor3 = RGB(255, 255, 255)
                Value1.TextSize = 14.000

                Value2.Name = "Value2"
                Value2.Parent = PickerFrame
                Value2.BackgroundColor3 = RGB(28, 28, 28)
                Value2.BorderColor3 = RGB(25, 25, 25)
                Value2.Position = u2(0, 45, 1, -50)
                Value2.Size = u2(0.330000013, -10, 0, 20)
                Value2.ClearTextOnFocus = false
                Value2.Font = Enum.Font.SourceSans
                Value2.PlaceholderColor3 = RGB(255, 255, 255)
                Value2.Text = ""
                Value2.ZIndex = pickerzindex
                Value2.TextColor3 = RGB(255, 255, 255)
                Value2.TextSize = 14.000

                Value3.Name = "Value3"
                Value3.Parent = PickerFrame
                Value3.BackgroundColor3 = RGB(28, 28, 28)
                Value3.BorderColor3 = RGB(25, 25, 25)
                Value3.Position = u2(0, 85, 1, -50)
                Value3.Size = u2(0.330000013, -10, 0, 20)
                Value3.ClearTextOnFocus = false
                Value3.Font = Enum.Font.SourceSans
                Value3.ZIndex = pickerzindex
                Value3.PlaceholderColor3 = RGB(255, 255, 255)
                Value3.Text = ""
                Value3.TextColor3 = RGB(255, 255, 255)
                Value3.TextSize = 14.000

                CopyValues.Name = "CopyValues"
                CopyValues.Parent = PickerFrame
                CopyValues.AutoButtonColor = false
                CopyValues.BackgroundColor3 = RGB(28, 28, 28)
                CopyValues.BorderColor3 = RGB(25, 25, 25)
                CopyValues.Position = u2(0, 5, 1, -25)
                CopyValues.Size = u2(0, 116, 0, 20)
                CopyValues.ZIndex = pickerzindex
                CopyValues.Font = Enum.Font.SourceSans
                CopyValues.Text = "Copy"
                CopyValues.TextColor3 = RGB(255, 255, 255)
                CopyValues.TextSize = 14.000

                NewPickerLayer()
                Cursor.Name = "Cursor"
                Cursor.Parent = HSVBox
                Cursor.BackgroundColor3 = RGB(255, 255, 255)
                Cursor.BorderColor3 = RGB(28, 28, 28)
                -- Cursor.Rotation = 45.000
                Cursor.Position =  u2(0, 0, 0, 0)
                Cursor.ZIndex = pickerzindex
                Cursor.Size = u2(0, 2, 0, 2)

                HUEGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, RGB(255, 0, 4)), ColorSequenceKeypoint.new(0.10, RGB(255, 0, 200)), ColorSequenceKeypoint.new(0.20, RGB(153, 0, 255)), ColorSequenceKeypoint.new(0.30, RGB(0, 0, 255)), ColorSequenceKeypoint.new(0.40, RGB(0, 149, 255)), ColorSequenceKeypoint.new(0.50, RGB(0, 255, 209)), ColorSequenceKeypoint.new(0.60, RGB(0, 255, 55)), ColorSequenceKeypoint.new(0.70, RGB(98, 255, 0)), ColorSequenceKeypoint.new(0.80, RGB(251, 255, 0)), ColorSequenceKeypoint.new(0.90, RGB(255, 106, 0)), ColorSequenceKeypoint.new(1.00, RGB(255, 0, 0))}
                HUEGradient.Rotation = 90
                HUEGradient.Parent = HUEPicker

                Indicator.Name = "Indicator"
                Indicator.Parent = HUEPicker
                Indicator.BackgroundColor3 = RGB(255, 255, 255)
                Indicator.BorderColor3 = RGB(28, 28, 28)
                Indicator.Position =  u2(0, 0, 0, 0)
                Indicator.ZIndex = pickerzindex
                Indicator.Size = u2(1, 0, 0, 2)

                CopyValues.MouseEnter:Connect(function()
                    TS:Create(CopyValues, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0.3}):Play()
                end)
            
                CopyValues.MouseLeave:Connect(function()
                    TS:Create(CopyValues, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                end)

                CopyValues.MouseButton1Click:Connect(function()
                    setclipboard(Value1.Text..", "..Value2.Text..", "..Value3.Text)
                end)

                if info.default ~= nil then
                    Value1.Text = round(info.default.r*255)
                    Value2.Text = round(info.default.g*255)
                    Value3.Text = round(info.default.b*255)
                else
                    Value1.Text = "255"
                    Value2.Text = "255"
                    Value3.Text = "255"
                end

                Detector.MouseButton1Click:Connect(function()
                    -- Click:Play()
                    PickerFrame.Visible = not PickerFrame.Visible
                end)

                local connection1
                connection1 = UIS.InputBegan:Connect(function(input)
                    if DESTROY_GUI then
                        connection1:Disconnect()
                    end
                    if input.UserInputType == Enum.UserInputType.MouseButton2 and PickerFrame.Visible == true and MouseNotIn(PickerFrame) then
                        PickerFrame.Visible = false
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 and PickerFrame.Visible == true and MouseNotIn(Detector) and MouseNotIn(PickerFrame) then
                        PickerFrame.Visible = false
                    end
                end)

                local function PlaceColor(col) -- RGB Color
                    local h, s, v = ColorModule:rgbToHsv(col.r*255, col.g*255, col.b*255)

                    Indicator.Position = u2(0, 0, 0, HUEPicker.AbsoluteSize.Y - HUEPicker.AbsoluteSize.Y * h)
                    Cursor.Position = u2(0, HSVBox.AbsoluteSize.X * s - Cursor.AbsoluteSize.X/2, 0, HSVBox.AbsoluteSize.Y - HSVBox.AbsoluteSize.Y * v - Cursor.AbsoluteSize.Y/2)

                    HSVBox.BackgroundColor3 = HSV(h, 1, 1)
                    CallBack(col)
                end

                local function PlaceColorHSV(hsv) -- HSV Color
                    local h = hsv.h
                    local s = hsv.s
                    local v = hsv.v
                    HSVBox.BackgroundColor3 = HSV(h, 1, 1)
                    local newh, news, newv = ColorModule:hsvToRgb(h, s, v)
                    Value1.Text = round(newh)
                    Value2.Text = round(news)
                    Value3.Text = round(newv)
                    Detector.BackgroundColor3 = RGB(round(newh), round(news), round(newv))
                    CallBack(RGB(newh, news, newv))
                end

                if info.default ~= nil then
                    PlaceColor(info.default)
                else
                    PlaceColor(RGB(255, 255, 255))
                end
                
                local SelectingHUE = false
                local SelectingHSV = false

                local prev1
                Value1.Changed:Connect(function(property)
                    if (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and tonumber(Value1.Text) then
                        Value1.Text = clamp(tonumber(Value1.Text), 0, 255)
                        PlaceColor(RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text)))
                        Detector.BackgroundColor3 = RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text))
                        prev1 = tonumber(Value1.Text)
                    elseif (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and Value1.Text == " " then
                        Value1.Text = prev1
                    end
                end)

                local prev2
                Value2.Changed:Connect(function(property)
                    if (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and tonumber(Value2.Text) then
                        Value2.Text = clamp(tonumber(Value2.Text), 0, 255)
                        PlaceColor(RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text)))
                        Detector.BackgroundColor3 = RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text))
                        prev2 = tonumber(Value2.Text)
                    elseif (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and Value2.Text == " " then
                        Value2.Text = prev2
                    end
                end)

                local prev3
                Value3.Changed:Connect(function(property)
                    if (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and tonumber(Value3.Text) then
                        Value3.Text = clamp(tonumber(Value3.Text), 0, 255)
                        PlaceColor(RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text)))
                        Detector.BackgroundColor3 = RGB(tonumber(Value1.Text), tonumber(Value2.Text), tonumber(Value3.Text))
                        prev3 = tonumber(Value3.Text)
                    elseif (SelectingHUE == false and SelectingHSV == false) and tostring(property) == "Text" and Value3.Text == " " then
                        Value3.Text = prev3
                    end
                end)

                HUEPicker.MouseButton1Down:Connect(function()
                    SelectingHUE = true
                end)
                HSVBox.MouseButton1Down:Connect(function()
                    SelectingHSV = true
                end)
                local connection
                connection = UIS.InputEnded:Connect(function(input)
                    if DESTROY_GUI then
                        connection:Disconnect()
                    end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        SelectingHUE = false
                        SelectingHSV = false
                    end
                end)
                
                local c 
                c = game:service("RunService").RenderStepped:Connect(function()
                    if DESTROY_GUI then
                        c:Disconnect()
                    end
                    if SelectingHUE then
                        Indicator.Position = u2(0, 0, 0, clamp(Mouse.Y - HUEPicker.AbsolutePosition.Y, 0, HUEPicker.AbsoluteSize.Y))
                        local h1 = (HUEPicker.AbsoluteSize.Y - (Indicator.AbsolutePosition.Y - HUEPicker.AbsolutePosition.Y)) / HUEPicker.AbsoluteSize.Y
                        local s1 = (Cursor.AbsolutePosition.X - HSVBox.AbsolutePosition.X) / HSVBox.AbsoluteSize.X
                        local v1 = (HSVBox.AbsoluteSize.Y - (Cursor.AbsolutePosition.Y - HSVBox.AbsolutePosition.Y)) / HSVBox.AbsoluteSize.Y
                        PlaceColorHSV({h = h1, s = s1, v = v1})
                    end
                    if SelectingHSV then
                        Cursor.Position = u2(0, clamp(Mouse.X - HSVBox.AbsolutePosition.X, 0, HSVBox.AbsoluteSize.X), 0, clamp(Mouse.Y - HSVBox.AbsolutePosition.Y, 0, HSVBox.AbsoluteSize.Y))
                        local h1 = (HUEPicker.AbsoluteSize.Y - (Indicator.AbsolutePosition.Y - HUEPicker.AbsolutePosition.Y)) / HUEPicker.AbsoluteSize.Y
                        local s1 = (Cursor.AbsolutePosition.X - HSVBox.AbsolutePosition.X) / HSVBox.AbsoluteSize.X
                        local v1 = (HSVBox.AbsoluteSize.Y - (Cursor.AbsolutePosition.Y - HSVBox.AbsolutePosition.Y)) / HSVBox.AbsoluteSize.Y
                        Cursor.Position = u2(0, clamp(Mouse.X - HSVBox.AbsolutePosition.X, Cursor.AbsoluteSize.X/2, HSVBox.AbsoluteSize.X - Cursor.AbsoluteSize.X), 0, clamp(Mouse.Y - HSVBox.AbsolutePosition.Y, Cursor.AbsoluteSize.Y/2, HSVBox.AbsoluteSize.Y - Cursor.AbsoluteSize.Y))
                        PlaceColorHSV({h = h1, s = s1, v = v1})
                    end
                end)
            end
            function function_library:NewSlider(name, CallBack, info)
                local decimals = info.decimals or 1

                local Slider = new("Frame")
                local SliderName = new("TextLabel")
                local Value = new("TextLabel")
                local Detector = new("ImageButton")
                local Bar = new("Frame")
                local Bob = new("Frame")

                Slider.Name = "Slider"
                Slider.Parent = Section
                Slider.BackgroundColor3 = RGB(255, 255, 255)
                Slider.BackgroundTransparency = 1.000
                Slider.BorderSizePixel = 0
                Slider.Position = u2(0, 0, 1.5, 0)
                Slider.Size = u2(0, 214, 0, 45)

                SliderName.Name = "SliderName"
                SliderName.Parent = Slider
                SliderName.BackgroundColor3 = RGB(255, 255, 255)
                SliderName.BackgroundTransparency = 1.000
                SliderName.Position = u2(0, 11, 0, 0)
                SliderName.Size = u2(0, 2, 0, 30)
                SliderName.Font = Enum.Font.SourceSans
                SliderName.TextColor3 = _G["Theme"]["Item_Name_Color"]
                SliderName.Text = name
                SliderName.TextSize = 15.000
                SliderName.TextXAlignment = Enum.TextXAlignment.Left

                Value.Name = "Value"
                Value.Parent = Slider
                Value.BackgroundColor3 = RGB(255, 255, 255)
                Value.BackgroundTransparency = 1.000
                Value.Position = u2(1, -10, 0, 0)
                Value.Size = u2(0, 2, 0, 30)
                Value.Font = Enum.Font.Code
                Value.Text = tonumber(clamp(info.value, info.min, info.max))..tostring(info.suffix)
                Value.TextColor3 = _G["Theme"]["Slider_Value"]
                Value.TextSize = 12.000
                Value.TextXAlignment = Enum.TextXAlignment.Right

                Detector.Name = "Detector"
                Detector.Parent = Slider
                Detector.BackgroundColor3 = RGB(255, 255, 255)
                Detector.BackgroundTransparency = 1.000
                Detector.Position = u2(0, 10, 0.666999996, 0)
                Detector.Size = u2(1, -20, 0, 8)
                Detector.Image = ""
                Detector.ImageTransparency = 1.000

                Bar.Name = "Bar"
                Bar.Parent = Detector
                Bar.BackgroundColor3 = _G["Theme"]["Slider_Bar"]
                Bar.BorderSizePixel = 0
                Bar.Position = u2(0, 0, 0.5, -1)
                Bar.Size = u2(1, 0, 0, 2)

                Bob.Name = "Bob"
                Bob.Parent = Detector
                Bob.BackgroundColor3 = _G["Theme"]["Slider_Bob"]
                Bob.BorderSizePixel = 0
                Bob.Position = u2(0, 0, 0.5, -1)
                Bob.Size = u2(0, 2, 0, 4)

                Section.Size = u2(1, 0, 0, SectionListLayout.AbsoluteContentSize.Y)

                local Dragging = false
                Detector.MouseButton1Down:Connect(function()
                    Dragging = true
                end)
                local connection
                connection = UIS.InputEnded:Connect(function(input)
                    if DESTROY_GUI then
                        connection:Disconnect()
                    end
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                    end
                end)

                local function Place(val)
                    local size = Bob.AbsoluteSize
                    local difference = info.max - info.min
                    local factor = abs(clamp(val, info.min, info.max) + abs(info.min)) / difference
                    Bob.Position = u2(0, clamp(factor * (Bar.AbsoluteSize.X - size.X), 0, Bar.AbsoluteSize.X - size.X), 0.5, -size.Y/2)
                end
                Place(info.value)

                local previous = nil
                local c 
                c = game:service("RunService").RenderStepped:Connect(function()
                    if DESTROY_GUI then
                        c:Disconnect()
                    end
                    if Dragging then
                        -- PLACE BOB
                        local size = Bob.AbsoluteSize
                        local pos = Bob.AbsolutePosition
                        local offset = pos.X - Bar.AbsolutePosition.X
                        local mouseoffset = Mouse.X - pos.X
                        Bob.Position = u2(0, clamp(offset + mouseoffset, 0, Bar.AbsoluteSize.X - size.X), 0.5, -size.Y/2)
                        
                        -- CALCULATIONS
                        local difference = info.max - info.min
                        local distance = Bob.AbsolutePosition.X - Bar.AbsolutePosition.X
                        local outcome = nil
                        outcome = round(info.min + distance * difference / (Bar.AbsoluteSize.X - size.X))
                        if decimals > 1 then
                            local str = "1"
                            for i = 1, decimals do 
                                str = str.."0"
                            end
                            outcome = floor((info.min + distance * difference / (Bar.AbsoluteSize.X - size.X)) * tonumber(str))/tonumber(str)
                        end
                        Value.Text = tostring(outcome)..tostring(info.suffix)
                        if outcome ~= previous then
                            previous = outcome
                            CallBack(outcome)
                        end
                    end
                end)
            end
            function function_library:NewKeybind(name, CallBack, info)
                local current_bind = info.keybind or ""

                local Keybind = new("Frame")
                local KeybindName = new("TextLabel")
                local Detector = new("TextButton")

                Keybind.Name = "Keybind"
                Keybind.Parent = Section
                Keybind.BackgroundColor3 = RGB(255, 255, 255)
                Keybind.BackgroundTransparency = 1.000
                Keybind.BorderSizePixel = 0
                Keybind.Position = u2(0, 0, 0.134468913, 0)
                Keybind.Size = u2(1, 0, 0, 30)

                KeybindName.Name = "KeybindName"
                KeybindName.Parent = Keybind
                KeybindName.BackgroundColor3 = RGB(255, 255, 255)
                KeybindName.BackgroundTransparency = 1.000
                KeybindName.Position = u2(0, 10, 0, 0)
                KeybindName.Size = u2(0, 2, 1, 0)
                KeybindName.Font = Enum.Font.SourceSans
                KeybindName.TextColor3 = _G["Theme"]["Item_Name_Color"]
                KeybindName.Text = name
                KeybindName.TextSize = 15.000
                KeybindName.TextXAlignment = Enum.TextXAlignment.Left

                Detector.Name = "Detector"
                Detector.Parent = Keybind
                Detector.BackgroundColor3 = RGB(29, 29, 29)
                Detector.BorderColor3 = _G["Theme"]["Keybind_Border"]
                Detector.Position = u2(1, -110, 0.5, -10)
                Detector.Size = u2(0, 100, 0, 20)
                Detector.AutoButtonColor = false
                Detector.Font = Enum.Font.SourceSans
                Detector.Text = stringsub(tostring(current_bind), 14, #tostring(current_bind))
                Detector.TextColor3 = RGB(255, 255, 255)
                Detector.TextSize = 14.000

                Section.Size = u2(1, 0, 0, SectionListLayout.AbsoluteContentSize.Y)

                Detector.MouseEnter:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0.3}):Play()
                end)
            
                Detector.MouseLeave:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                end)

                local Selecting = false

                local function Scale(word)
                    local scale = #word * 100 / 12
                    Detector.Size = u2(0, scale, 0, 20)
                    Detector.Position = u2(1, -scale - 10, 0.5, -10)
                end
                Scale(stringsub(tostring(current_bind), 14, #tostring(current_bind)))

                Detector.MouseButton1Click:Connect(function()
                    Selecting = true
                    Detector.Text = ""
                    Scale("[]")
                    local connection
                    local connection2
                    connection = UIS.InputBegan:Connect(function(input)
                        if DESTROY_GUI then
                            connection:Disconnect()
                        end
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            -- Click:Play()
                            current_bind = input.KeyCode
                            Detector.Text = stringsub(tostring(current_bind), 14, #tostring(current_bind))
                            Scale("["..stringsub(tostring(current_bind), 14, #tostring(current_bind)).."]")
                            connection:Disconnect()
                            connection2:Disconnect()
                            wait()
                            Selecting = false
                        end
                    end)
                    connection2 = UIS.InputBegan:Connect(function(input)
                        if DESTROY_GUI then
                            connection2:Disconnect()
                        end
                        if input.UserInputType == Enum.UserInputType.MouseButton2 then
                            Detector.Text = "NONE"
                            Scale("[NONE]")
                            current_bind = nil
                            connection:Disconnect()
                            connection2:Disconnect()
                            wait()
                            Selecting = false
                        end
                    end)
                end)

                local c
                c = UIS.InputBegan:Connect(function(input)
                    if DESTROY_GUI then
                        c:Disconnect()
                    elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == current_bind and Selecting == false then
                        CallBack(tostring(current_bind))
                    end
                end)

                local keybind_function_library = {}
                function keybind_function_library:UpdateKeybind(newbind)
                    current_bind = newbind
                    Detector.Text = stringsub(tostring(current_bind), 14, #tostring(current_bind))
                    Scale("["..stringsub(tostring(current_bind), 14, #tostring(current_bind)).."]")
                end

                function keybind_function_library:Fire(times)
                    local n = times or 1
                    for i = 1, n do
                        CallBack()
                    end
                end

                return keybind_function_library
            end
            function function_library:NewDropdown(name, CallBack, info)
                local current_option = info.options[info.default] or info.options[1]
                local Dropdown = new("Frame")
                local DropdownName = new("TextLabel")
                local Detector = new("TextButton")
                local Arrow = new("ImageLabel")
                local OptionsList = new("Frame")
                local OptionsLayout = new("UIListLayout")

                Dropdown.Name = "Dropdown"
                Dropdown.Parent = Section
                Dropdown.BackgroundColor3 = RGB(255, 255, 255)
                Dropdown.BackgroundTransparency = 1.000
                Dropdown.BorderSizePixel = 0
                Dropdown.Position = u2(0, 0, 1.5, 0)
                Dropdown.Size = u2(1, 0, 0, 55)

                DropdownName.Name = "DropdownName"
                DropdownName.Parent = Dropdown
                DropdownName.BackgroundColor3 = RGB(255, 255, 255)
                DropdownName.BackgroundTransparency = 1.000
                DropdownName.Position = u2(0, 11, 0, 0)
                DropdownName.Size = u2(0, 2, 0, 30)
                DropdownName.Font = Enum.Font.SourceSans
                DropdownName.TextColor3 = _G["Theme"]["Item_Name_Color"]
                DropdownName.Text = name
                DropdownName.TextSize = 15.000
                DropdownName.TextXAlignment = Enum.TextXAlignment.Left

                Detector.Name = "Detector"
                Detector.Parent = Dropdown
                Detector.BackgroundColor3 = RGB(29, 29, 29)
                Detector.BorderColor3 = _G["Theme"]["Dropdown_Border"]
                Detector.Position = u2(0, 10, 0, 30)
                Detector.Size = u2(1, -20, 0, 20)
                Detector.ZIndex = 2
                
                NewDropdownLayer()
                Detector.AutoButtonColor = false
                Detector.Font = Enum.Font.SourceSans
                Detector.TextColor3 = RGB(255, 255, 255)
                Detector.ZIndex = 2
                Detector.TextSize = 14.000
                Detector.TextColor3 = _G["Theme"]["Dropdown_Main_Option"]
                Detector.TextWrapped = true

                Arrow.Name = "Arrow"
                Arrow.Parent = Detector
                Arrow.BackgroundColor3 = RGB(255, 255, 255)
                Arrow.BackgroundTransparency = 1.000
                Arrow.BorderSizePixel = 0
                Arrow.Position = u2(1, -20, 0.5, -2)
                Arrow.Size = u2(0, 10, 0, 6)
                Arrow.ZIndex = 3
                Arrow.Image = "rbxassetid://6820979846"
                Arrow.ImageColor3 = _G["Theme"]["Dropdown_Arrow"]

                Section.Size = u2(1, 0, 0, SectionListLayout.AbsoluteContentSize.Y)

                OptionsList.Name = "OptionsList"
                OptionsList.Parent = Dropdown
                OptionsList.BackgroundColor3 = RGB(28, 28, 28)
                OptionsList.BackgroundTransparency = 1.000
                OptionsList.BorderColor3 = RGB(25, 25, 25)
                OptionsList.Position = u2(0, 10, 0, 52)
                OptionsList.Size = u2(1, -20, 0, 20)
                OptionsList.ZIndex = dropdownzindex
                OptionsList.Visible = false

                OptionsLayout.Name = "OptionsLayout"
                OptionsLayout.Parent = OptionsList
                OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
                OptionsLayout.Padding = UDim.new(0, 1)
                
                local function Select(option)
                    CallBack(option)
                    OptionsList.Visible = false
                    Detector.Text = option
                end
                Select(current_option)

                Detector.MouseEnter:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0.3}):Play()
                end)
            
                Detector.MouseLeave:Connect(function()
                    TS:Create(Detector, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                end)

                Detector.MouseButton1Click:Connect(function()
                    -- Click:Play()
                    OptionsList.Visible = not OptionsList.Visible
                end)

                local function ReMap()
                    for _,v in pairs(OptionsList:GetChildren()) do
                        if not v:IsA("UIListLayout") then
                            for u,x in pairs(getconnections(v.MouseEnter)) do
                                x:Disable()
                            end
                            for u,x in pairs(getconnections(v.MouseLeave)) do
                                x:Disable()
                            end
                            for u,x in pairs(getconnections(v.MouseButton1Click)) do
                                x:Disable()
                            end
                            v:Destroy()
                        end
                    end
                    for _,v in pairs(info.options) do
                        local Option = new("TextButton")
                        Option.Name = "Option"
                        Option.Parent = OptionsList
                        Option.BackgroundColor3 = RGB(29, 29, 29)
                        Option.BorderColor3 = RGB(25, 25, 25)
                        Option.Size = u2(1, 0, 0, 20)
                        Option.AutoButtonColor = false
                        Option.Font = Enum.Font.SourceSans
                        Option.Text = v
                        Option.ZIndex = dropdownzindex-1
                        Option.TextColor3 = _G["Theme"]["Dropdown_Options"]
                        Option.TextSize = 13.000
    
                        Option.MouseEnter:Connect(function()
                            TS:Create(Option, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(26, 26, 26)}):Play()
                        end)
        
                        Option.MouseLeave:Connect(function()
                            TS:Create(Option, tween(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = RGB(29, 29, 29)}):Play()
                        end)
    
                        Option.MouseButton1Click:Connect(function()
                            Select(v)
                        end)
                    end
                end
                ReMap()
                NewDropdownLayer()
                
                local dropdown_functions_library = {}
                function dropdown_functions_library:SelectOption(name)
                    for _,v in pairs(info.options) do
                        if tostring(v) == tostring(name) then
                            Select(v)
                        end
                    end
                end
                function dropdown_functions_library:AddOption(name)
                    table.insert(info.options, name)
                    ReMap()
                end
                function dropdown_functions_library:RemoveOption(name)
                    local newtbl = {}
                    for _,v in pairs(info.options) do
                        if tostring(v) ~= tostring(name) then
                            table.insert(newtbl, v)
                        end
                    end
                    info.options = newtbl
                    ReMap()
                end
                return dropdown_functions_library
            end
            return function_library
        end
        return section_lib
    end
    return structurer
end

return Library
