-- ================= OPERATION ONE - self-contained (Samet UI library auto-loads) =================
if not getgenv().Library then
-- made by samet (joestar._3 on discord)
-- https://discord.gg/VhvTd5HV8d

print("start")

if getgenv().Library then
    getgenv().Library:Unload()
end

local Library; do 
    local Workspace = game:GetService("Workspace")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local RunService = game:GetService("RunService")
    local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")

    gethui = gethui or function()
        return CoreGui
    end

    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()

    local FromRGB = Color3.fromRGB
    local FromHSV = Color3.fromHSV
    local FromHex = Color3.fromHex

    local RGBSequence = ColorSequence.new
    local RGBSequenceKeypoint = ColorSequenceKeypoint.new

    local UDim2New = UDim2.new
    local UDimNew = UDim.new
    local Vector2New = Vector2.new

    local MathClamp = math.clamp
    local MathFloor = math.floor

    local TableInsert = table.insert
    local TableFind = table.find
    local TableRemove = table.remove
    local TableConcat = table.concat
    local TableClone = table.clone
    local TableUnpack = table.unpack

    local StringFormat = string.format
    local StringFind = string.find
    local StringGSub = string.gsub
    local StringLen = string.len
    local StringSub = string.sub

    local InstanceNew = Instance.new

    Library = {
        Theme =  { },

        MenuKeybind = tostring(Enum.KeyCode.Z), 

        Flags = { },

        Tween = {
            Time = 0.4,
            Style = Enum.EasingStyle.Quint,
            Direction = Enum.EasingDirection.Out
        },

        FadeSpeed = 0.2,

        Folders = {
            Directory = "esdeeeeee",
            Configs = "esdeeeeee/Configs",
            Assets = "esdeeeeee/Assets",
        },

        -- Ignore below
        Pages = { },
        Sections = { },

        Connections = { },
        Threads = { },

        ThemeMap = { },
        ThemeItems = { },

        OpenFrames = { },

        SetFlags = { },

        UnnamedConnections = 0,
        UnnamedFlags = 0,

        Holder = nil,
        NotifHolder = nil,
        UnusedHolder = nil,

        Font = nil
    }

    local Keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBacked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    local Themes = {
        ["Preset"] = {
            ["Background"] = FromRGB(16, 18, 18),
            ["Inline"] = FromRGB(21, 24, 24),
            ["Element"] = FromRGB(30, 34, 34),
            ["Accent"] = FromRGB(255, 255, 255),
            ["Border"] = FromRGB(30, 34, 34),
            ["Border 2"] = FromRGB(56, 62, 62)
        }
    }

    Library.__index = Library
    Library.Sections.__index = Library.Sections
    Library.Pages.__index = Library.Pages

    Library.Theme = TableClone(Themes["Preset"])

    -- Folders
    for Index, Value in Library.Folders do 
        if not isfolder(Value) then
            makefolder(Value)
        end
    end

    -- Tweening
    local Tween = { } do
        Tween.__index = Tween

        Tween.Create = function(self, Item, Info, Goal, IsRawItem)
            Item = IsRawItem and Item or Item.Instance
            Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

            local NewTween = {
                Tween = TweenService:Create(Item, Info, Goal),
                Info = Info,
                Goal = Goal,
                Item = Item
            }

            NewTween.Tween:Play()

            setmetatable(NewTween, Tween)

            return NewTween
        end

        Tween.GetProperty = function(self, Item)
            Item = Item or self.Item 

            if Item:IsA("Frame") then
                return { "BackgroundTransparency" }
            elseif Item:IsA("TextLabel") or Item:IsA("TextButton") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("ImageLabel") or Item:IsA("ImageButton") then
                return { "BackgroundTransparency", "ImageTransparency" }
            elseif Item:IsA("ScrollingFrame") then
                return { "BackgroundTransparency", "ScrollBarImageTransparency" }
            elseif Item:IsA("TextBox") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("UIStroke") then 
                return { "Transparency" }
            end
        end

        Tween.FadeItem = function(self, Item, Property, Visibility, Speed)
            local Item = Item or self.Item 

            local OldTransparency = Item[Property]
            Item[Property] = Visibility and 1 or OldTransparency

            local NewTween = Tween:Create(Item, TweenInfo.new(Speed or Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction), {
                [Property] = Visibility and OldTransparency or 1
            }, true)

            Library:Connect(NewTween.Tween.Completed, function()
                if not Visibility then 
                    task.wait()
                    Item[Property] = OldTransparency
                end
            end)

            return NewTween
        end

        Tween.Get = function(self)
            if not self.Tween then 
                return
            end

            return self.Tween, self.Info, self.Goal
        end

        Tween.Pause = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Pause()
        end

        Tween.Play = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Play()
        end

        Tween.Clean = function(self)
            if not self.Tween then 
                return
            end

            Tween:Pause()
            self = nil
        end
    end

    -- Instances
    local Instances = { } do
        Instances.__index = Instances

        Instances.Create = function(self, Class, Properties)
            local NewItem = {
                Instance = InstanceNew(Class),
                Properties = Properties,
                Class = Class
            }

            setmetatable(NewItem, Instances)

            for Property, Value in NewItem.Properties do
                NewItem.Instance[Property] = Value
            end

            return NewItem
        end

        Instances.AddToTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:AddToTheme(self, Properties)
        end

        Instances.ChangeItemTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:ChangeItemTheme(self, Properties)
        end

        Instances.Connect = function(self, Event, Callback, Name)
            if not self.Instance then 
                return
            end

            if not self.Instance[Event] then 
                return
            end

            return Library:Connect(self.Instance[Event], Callback, Name)
        end

        Instances.Tween = function(self, Info, Goal)
            if not self.Instance then 
                return
            end

            return Tween:Create(self, Info, Goal)
        end

        Instances.Disconnect = function(self, Name)
            if not self.Instance then 
                return
            end

            return Library:Disconnect(Name)
        end

        Instances.Clean = function(self)
            if not self.Instance then 
                return
            end

            self.Instance:Destroy()
            self = nil
        end

        Instances.MakeDraggable = function(self)
            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local Dragging = false 
            local DragStart
            local StartPosition 

            local Set = function(Input)
                local DragDelta = Input.Position - DragStart
                self:Tween(TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(StartPosition.X.Scale, StartPosition.X.Offset + DragDelta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + DragDelta.Y)})
            end

            local InputChanged

            self:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true

                    DragStart = Input.Position
                    StartPosition = Gui.Position

                    if InputChanged then 
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Dragging = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Dragging then
                        Set(Input)
                    end
                end
            end)

            return Dragging
        end

        Instances.MakeResizeable = function(self, Minimum, Maximum)
            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local Resizing = false 
            local Start = UDim2New()
            local Delta = UDim2New()
            local ResizeMax = Gui.Parent.AbsoluteSize - Gui.AbsoluteSize

            local ResizeButton = Instances:Create("ImageButton", {
				Parent = Gui,
                Image = "rbxassetid://",
				AnchorPoint = Vector2New(1, 1),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(0, 8, 0, 8),
				Position = UDim2New(1, -4, 1, -4),
                Name = "\0",
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
                ZIndex = 5,
				AutoButtonColor = false,
                Visible = true,
			})  ResizeButton:AddToTheme({ImageColor3 = "Accent"})

            local InputChanged

            ResizeButton:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then

                    Resizing = true

                    Start = Gui.Size - UDim2New(0, Input.Position.X, 0, Input.Position.Y)

                    if InputChanged then 
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Resizing = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Resizing then
                        ResizeMax = Maximum or Gui.Parent.AbsoluteSize - Gui.AbsoluteSize

                        Delta = Start + UDim2New(0, Input.Position.X, 0, Input.Position.Y)
                        Delta = UDim2New(0, math.clamp(Delta.X.Offset, Minimum.X, ResizeMax.X), 0, math.clamp(Delta.Y.Offset, Minimum.Y, ResizeMax.Y))

                        Tween:Create(Gui, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = Delta}, true)
                    end
                end
            end)

            return Resizing
        end

        Instances.OnHover = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseEnter, Function)
        end

        Instances.OnHoverLeave = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseLeave, Function)
        end
    end

    -- Custom font
    local CustomFont = { }; do
        function CustomFont:New(Name, Weight, Style, Data)
            if not isfile(Data.Id) then 
                writefile(Data.Id, game:HttpGet(Data.Url))
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = Name,
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Data.Id)
                    }
                }
            }

            writefile(`{Library.Folders.Fonts}/{Name}.font`, HttpService:JSONEncode(Data))
            return Font.new(getcustomasset(`{Library.Folders.Fonts}/{Name}.font`), Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        end

        Library.Font = CustomFont:New("InterSemiBold", "Regular", "Normal", {
            Id = "Inter",
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/InterSemibold.ttf"
        })
    end

    Library.Holder = Instances:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        DisplayOrder = 2,
        ResetOnSpawn = false
    })

    Library.UnusedHolder = Instances:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Enabled = false,
        ResetOnSpawn = false
    })

    Library.NotifHolder = Instances:Create("Frame", {
        Parent = Library.Holder.Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        Size = UDim2New(0, 0, 1, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = FromRGB(255, 255, 255)
    })
    
    Instances:Create("UIListLayout", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        Padding = UDimNew(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    Instances:Create("UIPadding", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        PaddingTop = UDimNew(0, 12),
        PaddingBottom = UDimNew(0, 12),
        PaddingRight = UDimNew(0, 12),
        PaddingLeft = UDimNew(0, 12)
    })

    Library.Unload = function(self)
        for Index, Value in self.Connections do 
            Value.Connection:Disconnect()
        end

        for Index, Value in self.Threads do 
            coroutine.close(Value)
        end

        if self.Holder then 
            self.Holder:Clean()
        end

        Library = nil 
        getgenv().Library = nil
    end

    Library.GetImage = function(self, Image)
        local ImageData = self.Images[Image]

        if not ImageData then 
            return
        end

        return getcustomasset(self.Folders.Assets .. "/" .. ImageData[1])
    end

    Library.Round = function(self, Number, Float)
        local Multiplier = 1 / (Float or 1)
        return MathFloor(Number * Multiplier) / Multiplier
    end

    Library.Thread = function(self, Function)
        local NewThread = coroutine.create(Function)
        
        coroutine.wrap(function()
            coroutine.resume(NewThread)
        end)()

        TableInsert(self.Threads, NewThread)
        return NewThread
    end
    
    Library.SafeCall = function(self, Function, ...)
        local Arguements = { ... }
        local Success, Result = pcall(Function, TableUnpack(Arguements))

        if not Success then
            warn(Result)
            return false
        end

        return Success
    end

    Library.Connect = function(self, Event, Callback, Name)
        Name = Name or StringFormat("connection_number_%s_%s", self.UnnamedConnections + 1, HttpService:GenerateGUID(false))

        local NewConnection = {
            Event = Event,
            Callback = Callback,
            Name = Name,
            Connection = nil
        }

        Library:Thread(function()
            NewConnection.Connection = Event:Connect(Callback)
        end)

        TableInsert(self.Connections, NewConnection)
        return NewConnection
    end

    Library.Disconnect = function(self, Name)
        for _, Connection in self.Connections do 
            if Connection.Name == Name then
                Connection.Connection:Disconnect()
                break
            end
        end
    end

    Library.NextFlag = function(self)
        local FlagNumber = self.UnnamedFlags + 1
        return StringFormat("flag_number_%s_%s", FlagNumber, HttpService:GenerateGUID(false))
    end

    Library.AddToTheme = function(self, Item, Properties)
        Item = Item.Instance or Item 

        local ThemeData = {
            Item = Item,
            Properties = Properties,
        }

        for Property, Value in ThemeData.Properties do
            if type(Value) == "string" then
                Item[Property] = self.Theme[Value]
            else
                Item[Property] = Value()
            end
        end

        TableInsert(self.ThemeItems, ThemeData)
        self.ThemeMap[Item] = ThemeData
    end

	Library.ToRich = function(self, Text, Color)
		return `<font color="rgb({MathFloor(Color.R * 255)}, {MathFloor(Color.G * 255)}, {MathFloor(Color.B * 255)})">{Text}</font>`
	end

    Library.GetConfig = function(self)
        local Config = { } 

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Key then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
                elseif type(Value) == "table" and Value.Color then
                    Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end
        end)

        return HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Key then 
                    SetFunction(Value)
                elseif type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                else
                    SetFunction(Value)
                end
            end
        end)

        return Success, Result
    end

    Library.DeleteConfig = function(self, Config)
        if isfile(Library.Folders.Configs .. "/" .. Config) then 
            delfile(Library.Folders.Configs .. "/" .. Config)
        end
    end

    Library.RefreshConfigsList = function(self, Element)
        local CurrentList = { }
        local List = { }

        local ConfigFolderName = StringGSub(Library.Folders.Configs, Library.Folders.Directory .. "/", "")

        for Index, Value in listfiles(Library.Folders.Configs) do
            local FileName = StringGSub(Value, Library.Folders.Directory .. "\\" .. ConfigFolderName .. "\\", "")
            List[Index] = FileName
        end

        local IsNew = #List ~= CurrentList

        if not IsNew then
            for Index = 1, #List do
                if List[Index] ~= CurrentList[Index] then
                    IsNew = true
                    break
                end
            end
        else
            CurrentList = List
            Element:Refresh(CurrentList)
        end
    end

    Library.ChangeItemTheme = function(self, Item, Properties)
        Item = Item.Instance or Item

        if not self.ThemeMap[Item] then 
            return
        end

        self.ThemeMap[Item].Properties = Properties
        self.ThemeMap[Item] = self.ThemeMap[Item]
    end

    Library.ChangeTheme = function(self, Theme, Color)
        self.Theme[Theme] = Color

        for _, Item in self.ThemeItems do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and Value == Theme then
                    Item.Item[Property] = Color
                elseif type(Value) == "function" then
                    Item.Item[Property] = Value()
                end
            end
        end
    end

    Library.IsMouseOverFrame = function(self, Frame)
        Frame = Frame.Instance

        local MousePosition = Vector2New(Mouse.X, Mouse.Y)

        return MousePosition.X >= Frame.AbsolutePosition.X and MousePosition.X <= Frame.AbsolutePosition.X + Frame.AbsoluteSize.X 
        and MousePosition.Y >= Frame.AbsolutePosition.Y and MousePosition.Y <= Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y
    end

    Library.Lerp = function(self, Start, Finish, Time)
        return Start + (Finish - Start) * Time
    end

    Library.CompareVectors = function(self, PointA, PointB)
        return (PointA.X < PointB.X) or (PointA.Y < PointB.Y)
    end

    Library.IsClipped = function(self, Object, Column)
        local Parent = Column
        
        local BoundryTop = Parent.AbsolutePosition
        local BoundryBottom = BoundryTop + Parent.AbsoluteSize

        local Top = Object.AbsolutePosition
        local Bottom = Top + Object.AbsoluteSize 

        return Library:CompareVectors(Top, BoundryTop) or Library:CompareVectors(BoundryBottom, Bottom)
    end

    do
        Library.CreateColorpicker = function(self, Data)
            local Colorpicker = {
                Hue = 0,
                Saturation = 0,
                Value = 0,

                Color = FromRGB(0, 0, 0),
                HexValue = "000000",

                Flag = Data.Flag,

                IsOpen = false
            }

            local Items = { }; do
                Items["ColorpickerButton"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2New(0, 14, 0, 14),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(164, 229, 255)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["ColorpickerButton"].Instance,
                    Name = "\0",
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = FromRGB(56, 62, 62),
                    Thickness = 1.5
                }):AddToTheme({Color = "Border 2"})
                
                Instances:Create("UICorner", {
                    Parent = Items["ColorpickerButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["ColorpickerWindow"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    Position = UDim2New(0, 115, 0, 102),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 183, 0, 201),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 18)
                })  Items["ColorpickerWindow"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Inline"] = Instances:Create("Frame", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 6, 0, 6),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -12, 1, -12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Inline"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UIStroke", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Palette"] = Instances:Create("TextButton", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "-,",
                    AutoButtonColor = false,
                    Position = UDim2New(0, 6, 0, 6),
                    Size = UDim2New(1, -12, 1, -40),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(164, 229, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["Saturation"] = Instances:Create("ImageLabel", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Image = "rbxassetid://130624743341203",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Saturation"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Value"] = Instances:Create("ImageLabel", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 2, 1, 0),
                    Image = "rbxassetid://96192970265863",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, -1, 0, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Value"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["PaletteDragger"] = Instances:Create("Frame", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 3, 0, 3),
                    Position = UDim2New(0, 5, 0, 5),
                    BorderColor3 = FromRGB(0, 0, 0),
                    ZIndex = 3,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["PaletteDragger"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["PaletteDragger"].Instance,
                    Name = "\0",
                    Color = FromRGB(120, 120, 120),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
                
                Items["Hue"] = Instances:Create("TextButton", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 6, 1, -6),
                    Size = UDim2New(1, -12, 0, 18),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Instances:Create("UIGradient", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 0, 0)), RGBSequenceKeypoint(0.17, FromRGB(255, 255, 0)), RGBSequenceKeypoint(0.33, FromRGB(0, 255, 0)), RGBSequenceKeypoint(0.5, FromRGB(0, 255, 255)), RGBSequenceKeypoint(0.67, FromRGB(0, 0, 255)), RGBSequenceKeypoint(0.83, FromRGB(255, 0, 255)), RGBSequenceKeypoint(1, FromRGB(255, 0, 0))}
                })
                
                Items["HueDragger"] = Instances:Create("Frame", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 2, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["HueDragger"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})                
            end

            local Debounce = false
            local RenderStepped  

            function Colorpicker:Get()
                return Colorpicker.Color
            end

            function Colorpicker:SetVisibility(Bool)
                Items["ColorpickerButton"].Instance.Visible = Bool
            end

            function Colorpicker:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Colorpicker.IsOpen = Bool

                Debounce = true 

                if Colorpicker.IsOpen then 
                    Items["ColorpickerWindow"].Instance.Visible = true
                    Items["ColorpickerWindow"].Instance.Parent = Library.Holder.Instance
                    
                    RenderStepped = RunService.RenderStepped:Connect(function()
                        Items["ColorpickerWindow"].Instance.Position = UDim2New(0, Items["ColorpickerButton"].Instance.AbsolutePosition.X + 18, 0, Items["ColorpickerButton"].Instance.AbsolutePosition.Y - 25)
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if not Data.Section.IsSettings then
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Colorpicker] = Colorpicker 
                else
                    if Library.OpenFrames[Colorpicker] then 
                        Library.OpenFrames[Colorpicker] = nil
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end
                end

                local Descendants = Items["ColorpickerWindow"].Instance:GetDescendants()
                TableInsert(Descendants, Items["ColorpickerWindow"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then
                        continue 
                    end

                    if not Value.ClassName:find("UI") then 
                        Value.ZIndex = Colorpicker.IsOpen and 4 or 1
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                    end
                end
                
                NewTween.Tween.Completed:Connect(function()
                    Debounce = false 
                    Items["ColorpickerWindow"].Instance.Visible = Colorpicker.IsOpen
                    task.wait(0.2)
                    Items["ColorpickerWindow"].Instance.Parent = not Colorpicker.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
                end)
            end

            function Colorpicker:Update()
                local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value
                Colorpicker.Color = FromHSV(Hue, Saturation, Value)
                Colorpicker.HexValue = Colorpicker.Color:ToHex()

                Library.Flags[Colorpicker.Flag] = {
                    Color = Colorpicker.Color,
                    HexValue = Colorpicker.HexValue,
                }

                Items["ColorpickerButton"]:Tween(nil, {BackgroundColor3 = Colorpicker.Color})
                Items["Palette"]:Tween(nil, {BackgroundColor3 = FromHSV(Hue, 1, 1)})

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Colorpicker.Color, Colorpicker.Alpha)
                end
            end

            local SlidingPalette = false
            local PaletteChanged
            
            function Colorpicker:SlidePalette(Input)
                if not Input or not SlidingPalette then
                    return
                end

                local ValueX = MathClamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                local ValueY = MathClamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

                Colorpicker.Saturation = ValueX
                Colorpicker.Value = ValueY

                local SlideX = MathClamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 0.98)
                local SlideY = MathClamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 0.98)

                Items["PaletteDragger"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, SlideY, 0)})
                Colorpicker:Update()
            end
            
            local SlidingHue = false
            local HueChanged

            function Colorpicker:SlideHue(Input)
                if not Input or not SlidingHue then
                    return
                end
                
                local ValueX = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 1)

                Colorpicker.Hue = ValueX

                local SlideX = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 0.995)

                Items["HueDragger"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, 0, 0)})
                Colorpicker:Update()
            end

            function Colorpicker:Set(Color, Alpha)
                if type(Color) == "table" then
                    Color = FromRGB(Color[1], Color[2], Color[3])
                    Alpha = Color[4]
                elseif type(Color) == "string" then
                    Color = FromHex(Color)
                end

                Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
                Colorpicker.Alpha = Alpha or 0  

                local PaletteValueX = MathClamp(1 - Colorpicker.Saturation, 0, 0.98)
                local PaletteValueY = MathClamp(1 - Colorpicker.Value, 0, 0.98)

                local HuePositionX = MathClamp(Colorpicker.Hue, 0, 0.99)

                Items["PaletteDragger"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(PaletteValueX, 0, PaletteValueY, 0)})
                Items["HueDragger"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(HuePositionX, 0, 0, 0)})
                Colorpicker:Update()
            end

            Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
                Colorpicker:SetOpen(not Colorpicker.IsOpen)
            end)

            Items["Palette"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    SlidingPalette = true 

                    Colorpicker:SlidePalette(Input)

                    if PaletteChanged then
                        return
                    end

                    PaletteChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingPalette = false

                            PaletteChanged:Disconnect()
                            PaletteChanged = nil
                        end
                    end)
                end
            end)

            Items["Hue"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    SlidingHue = true 

                    Colorpicker:SlideHue(Input)

                    if HueChanged then
                        return
                    end

                    HueChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingHue = false

                            HueChanged:Disconnect()
                            HueChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if Colorpicker.IsOpen then
                        if Library:IsMouseOverFrame(Items["ColorpickerWindow"]) then
                            return
                        end

                        Colorpicker:SetOpen(false)
                    end
                end
            end)
            
            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if SlidingPalette then 
                        Colorpicker:SlidePalette(Input)
                    end

                    if SlidingHue then 
                        Colorpicker:SlideHue(Input)
                    end
                end
            end)

            Items["ColorpickerButton"]:Connect("Changed", function(Property)
                if Property == "AbsolutePosition" and Colorpicker.IsOpen then
                    Colorpicker.IsOpen = not Library:IsClipped(Items["ColorpickerButton"].Instance, Data.Section.Items["Section"].Instance.Parent)
                    Items["ColorpickerWindow"].Instance.Visible = Colorpicker.IsOpen
                end
            end)

            if Data.Default then
                Colorpicker:Set(Data.Default)
            end

            Library.SetFlags[Colorpicker.Flag] = function(Color, Alpha)
                Colorpicker:Set(Color, Alpha)
            end

            return Colorpicker, Items 
        end

        Library.CreateKeybind = function(self, Data)
            local Keybind = {
                Flag = Data.Flag,

                Key = "",
                Value = "",
                Mode = "",
                Toggled = false,

                Picking = false,
                IsOpen = false
            }

            local Items = { }; do
                Items["KeyButton"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "-",
                    AutoButtonColor = false,
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["KeyButton"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["KeyButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["KeyButton"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 4),
                    PaddingLeft = UDimNew(0, 5)
                })                

                Items["KeybindWindow"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    Position = UDim2New(0, 231, 0, 102),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 67, 0, 92),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 18)
                })  Items["KeybindWindow"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Inline"] = Instances:Create("Frame", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 6, 0, 6),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -12, 1, -12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Inline"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UIStroke", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Toggle",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 4)
                })
                
                Items["Hold"] = Instances:Create("TextButton", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Hold",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Always"] = Instances:Create("TextButton", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Always",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })                
            end

            local Modes = {
                ["Always"] = Items["Always"],
                ["Hold"] = Items["Hold"],
                ["Toggle"] = Items["Toggle"]
            }

            local Debounce = false
            local RenderStepped 

            function Keybind:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Keybind.IsOpen = Bool

                Debounce = true 

                if Keybind.IsOpen then 
                    Items["KeybindWindow"].Instance.Visible = true
                    Items["KeybindWindow"].Instance.Parent = Library.Holder.Instance
                    
                    RenderStepped = RunService.RenderStepped:Connect(function()
                        Items["KeybindWindow"].Instance.Position = UDim2New(0, Items["KeyButton"].Instance.AbsolutePosition.X + 18, 0, Items["KeyButton"].Instance.AbsolutePosition.Y - 25)
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if not Data.Section.IsSettings then
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Keybind] = Keybind 
                else
                    if Library.OpenFrames[Keybind] then 
                        Library.OpenFrames[Keybind] = nil
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end
                end

                local Descendants = Items["KeybindWindow"].Instance:GetDescendants()
                TableInsert(Descendants, Items["KeybindWindow"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then
                        continue 
                    end

                    if not Value.ClassName:find("UI") then 
                        Value.ZIndex = Keybind.IsOpen and 2 or 1
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                    end
                end
                
                NewTween.Tween.Completed:Connect(function()
                    Debounce = false 
                    Items["KeybindWindow"].Instance.Visible = Keybind.IsOpen
                    task.wait(0.2)
                    Items["KeybindWindow"].Instance.Parent = not Keybind.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
                end)
            end

            function Keybind:SetMode(Mode)
                for Index, Value in Modes do 
                    if Index == Mode then
                        Value:Tween(nil, {TextColor3 = FromRGB(255, 255, 255)})
                    else
                        Value:Tween(nil, {TextColor3 = FromRGB(100, 100, 100)})
                    end
                end

                Library.Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end
            end

            function Keybind:Get()
                return Keybind.Key, Keybind.Mode, Keybind.Toggled
            end

            function Keybind:Set(Key)
                if StringFind(tostring(Key), "Enum") then 
                    Keybind.Key = tostring(Key)

                    Key = Key.Name == "Backspace" and "None" or Key.Name

                    local KeyString = Keys[Keybind.Key] or StringGSub(Key, "Enum.", "") or "None"
                    local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay

                    Library.Flags[Keybind.Flag] = {
                        Mode = Keybind.Mode,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                elseif type(Key) == "table" then
                    local RealKey = Key.Key == "Backspace" and "None" or Key.Key
                    Keybind.Key = tostring(Key.Key)

                    if Key.Mode then
                        Keybind.Mode = Key.Mode
                        Keybind:SetMode(Key.Mode)
                    else
                        Keybind.Mode = "Toggle"
                        Keybind:SetMode("Toggle")
                    end

                    local KeyString = Keys[Keybind.Key] or StringGSub(tostring(RealKey), "Enum.", "") or RealKey
                    local TextToDisplay = KeyString and StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                    TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "")

                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                elseif TableFind({"Toggle", "Hold", "Always"}, Key) then
                    Keybind.Mode = Key
                    Keybind:SetMode(Key)

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                end

                Keybind.Picking = false
            end

            function Keybind:Press(Bool)
                if Keybind.Mode == "Toggle" then 
                    Keybind.Toggled = not Keybind.Toggled
                elseif Keybind.Mode == "Hold" then 
                    Keybind.Toggled = Bool
                elseif Keybind.Mode == "Always" then 
                    Keybind.Toggled = true
                end

                Library.Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end
            end

            Items["KeyButton"]:Connect("MouseButton1Click", function()
                Keybind.Picking = true 

                Items["KeyButton"].Instance.Text = "."
                Library:Thread(function()
                    local Count = 1

                    while true do 
                        if not Keybind.Picking then 
                            break
                        end

                        if Count == 4 then
                            Count = 1
                        end

                        Items["KeyButton"].Instance.Text = Count == 1 and "." or Count == 2 and ".." or Count == 3 and "..."
                        Count += 1
                        task.wait(0.35)
                    end
                end)

                local InputBegan
                InputBegan = UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard then 
                        Keybind:Set(Input.KeyCode)
                    else
                        Keybind:Set(Input.UserInputType)
                    end

                    InputBegan:Disconnect()
                    InputBegan = nil
                end)
            end)

            Items["KeyButton"]:Connect("MouseButton2Down", function()
                Keybind:SetOpen(not Keybind.IsOpen)
            end)

            Items["KeyButton"]:Connect("Changed", function(Property)
                if Property == "AbsolutePosition" and Keybind.IsOpen then
                    Keybind.IsOpen = not Library:IsClipped(Items["KeybindWindow"].Instance, Data.Section.Items["Section"].Instance.Parent)
                    Items["KeybindWindow"].Instance.Visible = Keybind.IsOpen
                end
            end)

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Keybind.Mode = "Toggle"
                Keybind:SetMode("Toggle")
            end)

            Items["Hold"]:Connect("MouseButton1Down", function()
                Keybind.Mode = "Hold"
                Keybind:SetMode("Hold")
            end)

            Items["Always"]:Connect("MouseButton1Down", function()
                Keybind.Mode = "Always"
                Keybind:SetMode("Always")
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Keybind.Value == "None" then
                    return
                end

                if tostring(Input.KeyCode) == Keybind.Key then
                    if Keybind.Mode == "Toggle" then 
                        Keybind:Press()
                    elseif Keybind.Mode == "Hold" then 
                        Keybind:Press(true)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                elseif tostring(Input.UserInputType) == Keybind.Key then
                    if Keybind.Mode == "Toggle" then 
                        Keybind:Press()
                    elseif Keybind.Mode == "Hold" then 
                        Keybind:Press(true)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not Keybind.IsOpen then
                        return
                    end

                    if Library:IsMouseOverFrame(Items["KeybindWindow"]) then
                        return
                    end

                    Keybind:SetOpen(false)
                end
            end)

            Library:Connect(UserInputService.InputEnded, function(Input)
                if Keybind.Value == "None" then
                    return
                end

                if tostring(Input.KeyCode) == Keybind.Key then
                    if Keybind.Mode == "Hold" then 
                        Keybind:Press(false)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                elseif tostring(Input.UserInputType) == Keybind.Key then
                    if Keybind.Mode == "Hold" then 
                        Keybind:Press(false)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                end
            end)

            if Data.Default then 
                Keybind:Set({
                    Mode = Data.Mode or "Toggle",
                    Key = Data.Default,
                })
            end

            Library.SetFlags[Keybind.Flag] = function(Value)
                Keybind:Set(Value)
            end

            return Keybind, Items 
        end

        Library.Notification = function(self, Name, Duration, Icon)
            local Items = { }; do 
                Items["Notification"] = Instances:Create("Frame", {
                    Parent = Library.NotifHolder.Instance,
                    Name = "\0",
                    Size = UDim2New(0, 0, 0, 30),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(16, 18, 18)
                })  Items["Notification"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["UIStroke"] = Instances:Create("UIStroke", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })  Items["UIStroke"]:AddToTheme({Color = "Border"})
                
                Instances:Create("UIPadding", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 8)
                })
                
                if Icon then
                    Items["Icon"] = Instances:Create("ImageLabel", {
                        Parent = Items["Notification"].Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(255, 255, 255),
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 0.5),
                        Image = "rbxassetid://"..Icon,
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 0, 0.5, 0),
                        Size = UDim2New(0, 16, 0, 16),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                end
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Notification"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Name,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, Icon and 24 or 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  
            end

            local Size = Items["Notification"].Instance.AbsoluteSize

            for Index, Value in Items do 
                if Value.Instance:IsA("Frame") then
                    Value.Instance.BackgroundTransparency = 1
                elseif Value.Instance:IsA("TextLabel") then 
                    Value.Instance.TextTransparency = 1
                elseif Value.Instance:IsA("ImageLabel") then 
                    Value.Instance.ImageTransparency = 1
                elseif Value.Instance:IsA("UIStroke") then
                    Value.Instance.Transparency = 1
                end
            end 
            
            task.wait(0.3)

            Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.Y

            Library:Thread(function()
                for Index, Value in Items do 
                    if Value.Instance:IsA("Frame") then
                        Value:Tween(nil, {BackgroundTransparency = 0})
                    elseif Value.Instance:IsA("TextLabel") then 
                        Value:Tween(nil, {TextTransparency = 0})
                    elseif Value.Instance:IsA("ImageLabel") then 
                        Value:Tween(nil, {ImageTransparency = 0.5})
                    elseif Value.Instance:IsA("UIStroke") then
                        Value:Tween(nil, {Transparency = 0})
                    end
                end

                Items["Notification"]:Tween(nil, {Size = UDim2New(0, Size.X, 0, Size.Y)})

                task.delay(Duration, function()
                    for Index, Value in Items do 
                        if Value.Instance:IsA("Frame") then
                            Value:Tween(nil, {BackgroundTransparency = 1})
                        elseif Value.Instance:IsA("TextLabel") then 
                            Value:Tween(nil, {TextTransparency = 1})
                        elseif Value.Instance:IsA("ImageLabel") then 
                            Value:Tween(nil, {ImageTransparency = 1})
                        elseif Value.Instance:IsA("UIStroke") then
                            Value:Tween(nil, {Transparency = 1})
                        end
                    end

                    Items["Notification"]:Tween(nil, {Size = UDim2New(0, 0, 0, 0)})
                    task.wait(0.5)
                    Items["Notification"]:Clean()
                end)
            end)
        end

        Library.Window = function(self, Data)
            local StartTime = tick()
            Data = Data or { }

            local Window = {
                Name = Data.Name or Data.name or "Window",
                SubTitle = Data.SubTitle or Data.subtitle or "for PUBG",
                ExpiresIn = Data.ExpiresIn or Data.expiresin or "23d",
                
                Pages = { },
                Items = { },
                IsOpen = false
            }

            local Items = { }; do
                local FirstLetterOfName = StringSub(Window.Name, 1, 1)
                Items["MainFrame"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 798, 0, 599),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(16, 18, 18)
                })  Items["MainFrame"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["MainFrame"]:MakeDraggable()
                Items["MainFrame"]:MakeResizeable(Vector2New(Items["MainFrame"].Instance.AbsoluteSize.X, Items["MainFrame"].Instance.AbsoluteSize.Y), Vector2New(9999, 9999))
                
                Instances:Create("UICorner", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Side"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 215, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Title"] = Instances:Create("Frame", {
                    Parent = Items["Side"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 6, 0, 6),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -12, 0, 60),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Title"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["Background"] = Instances:Create("Frame", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 12, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 40, 0, 40),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(207, 207, 207)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = FirstLetterOfName,
                    AnchorPoint = Vector2New(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(1, -10, 1, -10),
                    BorderSizePixel = 0,
                    TextSize = 22,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["RealTitle"] = Instances:Create("TextLabel", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Window.Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 65, 0, 14),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  
                
                Items["Game"] = Instances:Create("TextLabel", {
                    Parent = Items["Title"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = Window.SubTitle,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 65, 0, 30),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Pages"] = Instances:Create("Frame", {
                    Parent = Items["Side"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 75),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, -80),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Pages"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Instances:Create("UIPadding", {
                    Parent = Items["Pages"].Instance,
                    Name = "\0",
                    PaddingLeft = UDimNew(0, 8)
                })                

                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 220, 0, 6),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -226, 1, -12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Content"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})          
                
                Items["Bottom_"] = Instances:Create("Frame", {
                    Parent = Items["Side"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 6, 1, -6),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -12, 0, 45),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Bottom_"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Bottom_"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Bottom_"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["SubExpires"] = Instances:Create("TextLabel", {
                    Parent = Items["Bottom_"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = "Sub expires in "..Window.ExpiresIn,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 10, 0, 8),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["SessionDuration"] = Instances:Create("TextLabel", {
                    Parent = Items["Bottom_"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Session duration: ",
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 10, 0, 23),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })                

                Library:Thread(function()
                    while task.wait(1) do
                        local SecondsPassed = MathFloor(tick() - StartTime)
                        local MinutesPassed = MathFloor(SecondsPassed / 60)

                        if MinutesPassed > 0 then
                            SecondsPassed = SecondsPassed - MinutesPassed * 60
                        end

                        Items["SessionDuration"].Instance.Text = "Session duration: "..MinutesPassed..":"..SecondsPassed
                    end
                end)

                Window.Items = Items
            end
            
            local Debounce = false

            function Window:SetCenter()
                local CenterPosition = Items["MainFrame"].Instance.AbsolutePosition
                task.wait()
                Items["MainFrame"].Instance.AnchorPoint = Vector2New(0, 0)

                Items["MainFrame"].Instance.Position = UDim2New(0, CenterPosition.X, 0, CenterPosition.Y)
            end

            function Window:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Window.IsOpen = Bool

                Debounce = true 

                if Window.IsOpen then 
                    Items["MainFrame"].Instance.Visible = true 
                end

                local Descendants = Items["MainFrame"].Instance:GetDescendants()
                TableInsert(Descendants, Items["MainFrame"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then
                        continue 
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                    end
                end
                
                NewTween.Tween.Completed:Connect(function()
                    Debounce = false 
                    Items["MainFrame"].Instance.Visible = Window.IsOpen
                end)
            end

            Library:Connect(UserInputService.InputBegan, function(Input)
                if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
                    Window:SetOpen(not Window.IsOpen)
                end
            end)

            Window:SetCenter()
            task.wait()
            Window:SetOpen(true)
            return setmetatable(Window, Library)
        end

        Library.Page = function(self, Data)
            Data = Data or { }

            local Page = {
                Window = self,

                Name = Data.Name or Data.name or "Page",
                Icon = Data.Icon or Data.icon or "136879043989014",

                Items = { },
                SubPages = { },
                Active = false
            }

            local Items = { }; do
                Items["Inactive"] = Instances:Create("TextButton", {
                    Parent = Page.Window.Items["Pages"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 200, 0, 30),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Inactive"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Items["UIStroke"] = Instances:Create("UIStroke", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    Transparency = 1,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })  Items["UIStroke"]:AddToTheme({Color = "Border"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = "rbxassetid://"..Page.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 10, 0.5, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Page.Name,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 38, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                                
                Items["Page"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["PageName"] = Instances:Create("TextLabel", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Page.Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 15, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 18,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["SubPages"] = Instances:Create("Frame", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    Size = UDim2New(0, 0, 0, 30),
                    Position = UDim2New(0, 13, 0, 42),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(16, 18, 18)
                })  Items["SubPages"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UIPadding", {
                    Parent = Items["SubPages"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 2),
                    PaddingBottom = UDimNew(0, 2),
                    PaddingRight = UDimNew(0, 2),
                    PaddingLeft = UDimNew(0, 2)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["SubPages"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 2),
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Instances:Create("UICorner", {
                    Parent = Items["SubPages"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })                

                Items["Columns"] = Instances:Create("Frame", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    Size = UDim2New(1, -20, 1, -82),
                    Position = UDim2New(0, 10, 0, 75),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    BackgroundTransparency = 1
                })  

                Page.Items = Items
            end

            local Debounce = false

            function Page:Turn(Bool)
                if Debounce then 
                    return 
                end

                Page.Active = Bool 
                
                Debounce = true
                Items["Page"].Instance.Visible = Bool 
                Items["Page"].Instance.Parent = Bool and Page.Window.Items["Content"].Instance or Library.UnusedHolder.Instance

                if Page.Active then
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 0})
                    Items["Icon"]:Tween(nil, {ImageColor3 = FromRGB(200, 200, 200)})
                    Items["Text"]:Tween(nil, {TextColor3 = FromRGB(200, 200, 200)})
                    Items["UIStroke"]:Tween(nil, {Transparency = 0})
                else
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 1})
                    Items["Icon"]:Tween(nil, {ImageColor3 = FromRGB(100, 100, 100)})
                    Items["Text"]:Tween(nil, {TextColor3 = FromRGB(100, 100, 100)})
                    Items["UIStroke"]:Tween(nil, {Transparency = 1})
                end

                Debounce = false
            end

            Items["Inactive"]:Connect("MouseButton1Down", function()
                for Index, Value in Page.Window.Pages do 
                    if Value == Page and Page.Active then
                        return
                    end

                    Value:Turn(Value == Page)
                end
            end)

            if #Page.Window.Pages == 0 then 
                Page:Turn(true)
            end

            TableInsert(Page.Window.Pages, Page)
            return setmetatable(Page, Library.Pages)
        end

        Library.Category = function(self, Name)
            local Items = { }; do
                Items["Category"] = Instances:Create("TextLabel", {
                    Parent = self.Items["Pages"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })                
            end

            return Items
        end

        Library.Pages.SubPage = function(self, Data)
            Data = Data or { }

            local Page = {
                Window = self.Window,
                Page = self,

                Name = Data.Name or Data.name or "SubPage",
                Columns = Data.Columns or Data.columns or 2,

                Items = { },
                ColumnsData = { },
                Active = false
            }

            local Items = { }; do 
                Items["Inactive"] = Instances:Create("TextButton", {
                    Parent = Page.Page.Items["SubPages"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = Page.Name,
                    AutoButtonColor = false,
                    Size = UDim2New(0, 0, 1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["Inactive"]:AddToTheme({BackgroundColor3 = "Element"})
                 
                Instances:Create("UIPadding", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    PaddingRight = UDimNew(0, 8),
                    PaddingLeft = UDimNew(0, 8)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })                

                Items["Page"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })

                Instances:Create("UIListLayout", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill
                })
            
                for Index = 1, Page.Columns do 
                    local NewColumn = Instances:Create("ScrollingFrame", {
                        Parent = Items["Page"].Instance,
                        Name = "\0",
                        ScrollBarImageColor3 = FromRGB(0, 0, 0),
                        Active = true,
                        BorderColor3 = FromRGB(0, 0, 0),
                        ScrollBarThickness = 0,
                        BackgroundTransparency = 1,
                        Size = UDim2New(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })
                    
                    if Index == 1 then
                        Instances:Create("UIPadding", {
                            Parent = NewColumn.Instance,
                            Name = "\0",
                            PaddingTop = UDimNew(0, 3),
                            PaddingBottom = UDimNew(0, 3),
                            PaddingRight = UDimNew(0, 8),
                            PaddingLeft = UDimNew(0, 3)
                        })                
                    elseif Index == 2 then
                        Instances:Create("UIPadding", {
                            Parent = NewColumn.Instance,
                            Name = "\0",
                            PaddingTop = UDimNew(0, 3),
                            PaddingBottom = UDimNew(0, 3),
                            PaddingRight = UDimNew(0, 20),
                            PaddingLeft = UDimNew(0, 8)
                        })
                    end

                    Page.ColumnsData[Index] = NewColumn
                end
            end

            local Debounce = false

            function Page:Turn(Bool)
                if Debounce then 
                    return 
                end

                Page.Active = Bool 
                
                Debounce = true
                Items["Page"].Instance.Visible = Bool 
                Items["Page"].Instance.Parent = Bool and Page.Page.Items["Columns"].Instance or Library.UnusedHolder.Instance

                if Page.Active then
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 0, TextTransparency = 0})
                else
                    Items["Inactive"]:Tween(nil, {BackgroundTransparency = 1, TextTransparency = 0.5})
                end

                Debounce = false
            end

            Items["Inactive"]:Connect("MouseButton1Down", function()
                for Index, Value in Page.Page.SubPages do 
                    if Value == Page and Page.Active then
                        return
                    end

                    Value:Turn(Value == Page)
                end
            end)

            if #Page.Page.SubPages == 0 then 
                Page:Turn(true)
            end

            TableInsert(Page.Page.SubPages, Page)
            return setmetatable(Page, Library.Pages)
        end

        Library.Pages.Section = function(self, Data)
            Data = Data or { }

            local Section = {
                Window = self.Window,
                Page = self,

                Name = Data.Name or Data.name or "Section",
                Icon = Data.Icon or Data.icon or "",
                Side = Data.Side or Data.side or 1,

                Items = { }
            }

            local Items = { }; do
                Items["Section"] = Instances:Create("Frame", {
                    Parent = Section.Page.ColumnsData[Section.Side].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 25),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["Section"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Image = "rbxassetid://"..Section.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 12),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    PaddingBottom = UDimNew(0, 12)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Section.Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 35, 0, 12),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 42),
                    Size = UDim2New(1, -24, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Section.Items = Items
            end

            return setmetatable(Section, Library.Sections)
        end

        Library.Sections.Toggle = function(self, Data)
            Data = Data or { }

            local Toggle = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Toggle",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or false,
                Callback = Data.Callback or Data.callback or function() end,

                Value = false
            }

            local Items = { }; do 
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Toggle.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 16),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Toggle.Name,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Indicator"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0, 14, 0, 14),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(30, 33, 33)
                })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UIStroke", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = FromRGB(56, 62, 62),
                    Thickness = 2
                }):AddToTheme({Color = "Border 2"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Inline"] = Instances:Create("Frame", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Inline"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["CheckImage"] = Instances:Create("ImageLabel", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://132128200461292",
                    ImageTransparency = 1,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(1, -4, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -25, 0, 0),
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDimNew(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                
            end

            function Toggle:Get()
                return Toggle.Value 
            end

            function Toggle:Set(Value)
                Toggle.Value = Value 
                Library.Flags[Toggle.Flag] = Value 

                if Toggle.Value then 
                    Items["Inline"]:Tween(nil,  {BackgroundTransparency = 0})
                    Items["CheckImage"]:Tween(nil, {ImageTransparency = 0})
                    Items["Text"]:Tween(nil, {TextColor3 = FromRGB(255, 255, 255)})
                else
                    Items["Inline"]:Tween(nil,  {BackgroundTransparency = 1})
                    Items["CheckImage"]:Tween(nil, {ImageTransparency = 1})
                    Items["Text"]:Tween(nil, {TextColor3 = FromRGB(100, 100, 100)})
                end

                if Toggle.Callback then 
                    Library:SafeCall(Toggle.Callback, Toggle.Value)
                end
            end

            function Toggle:SetVisibility(Bool)
                Items["Toggle"].Instance.Visible = Bool 
            end

            function Toggle:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end
                }

                local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback
                })

                return NewColorpicker
            end

            function Toggle:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Enum.KeyCode.E,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle"
                }

                local NewKeybind = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Toggle:Set(not Toggle.Value)
            end)

            Toggle:Set(Toggle.Default)

            Library.SetFlags[Toggle.Flag] = function(Value)
                Toggle:Set(Value)
            end

            return Toggle 
        end

        Library.Sections.Button = function(self, Data)
            Data = Data or { }

            local Button = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name,
                Callback = Data.Callback or Data.callback or function() end
            }

            local Items = { }; do
                Items["Button"] = Instances:Create("TextButton", {
                    Parent = Button.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Button.Name,
                    AutoButtonColor = false,
                    Size = UDim2New(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["Button"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = FromRGB(56, 62, 62),
                    Thickness = 2
                }):AddToTheme({Color = "Border 2"})
                
                Instances:Create("UIPadding", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    PaddingBottom = UDimNew(0, 1)
                })                
            end

            function Button:SetVisibility(Bool)
                Items["Button"].Instance.Visible = Bool
            end

            function Button:Press()
                Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent, TextColor3 = FromRGB(0, 0, 0)})

                task.wait(0.1)

                Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element, TextColor3 = FromRGB(255, 255, 255)})

                Library:SafeCall(Button.Callback)
            end

            Items["Button"]:Connect("MouseButton1Down", function()
                Button:Press()
            end)

            return Button
        end

        Library.Sections.Slider = function(self, Data)
            Data = Data or { }

            local Slider = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Slider",
                Min = Data.Min or Data.min or 0,
                Max = Data.Max or Data.max or 100,
                Callback = Data.Callback or Data.callback or function() end,
                Default = Data.Default or Data.default or 0,
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Decimals = Data.Decimals or Data.decimals or 1,
                Suffix = Data.Suffix or Data.suffix or "",

                Value = 0,
                Sliding = false
            }

            local Items = { }; do 
                Items["Slider"] = Instances:Create("Frame", {
                    Parent = Slider.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 30),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Slider.Name,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Value"] = Instances:Create("TextLabel", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AnchorPoint = Vector2New(1, 0),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["RealSlider"] = Instances:Create("TextButton", {
                    Parent = Items["Slider"].Instance,
                    Text = "",
                    AutoButtonColor = false,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["RealSlider"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0.4000000059604645, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Accent"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Items["Circle"] = Instances:Create("Frame", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, 5, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 8, 0, 8),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Circle"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Circle"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 7)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(180, 180, 180)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))}
                })                
            end

            function Slider:Get()
                return Slider.Value
            end

            function Slider:SetVisibility(Bool)
                Items["Slider"].Instance.Visible = Bool
            end

            function Slider:Set(Value)
                Slider.Value = Library:Round(MathClamp(Value, Slider.Min, Slider.Max), Slider.Decimals)
                Library.Flags[Slider.Flag] = Slider.Value

                Items["Accent"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), -2, 1, 0)})
                Items["Value"].Instance.Text = StringFormat("%s%s", Slider.Value, Slider.Suffix)

                if Slider.Callback then
                    Library:SafeCall(Slider.Callback, Slider.Value)
                end
            end

            local InputChanged
            local InputChanged2

            Items["RealSlider"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Slider.Sliding = true

                    local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                    local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                    Slider:Set(Value)

                    if InputChanged then
                        return 
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Slider.Sliding = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Items["Circle"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Slider.Sliding = true

                    local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                    local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                    Slider:Set(Value)

                    if InputChanged2 or InputChanged then
                        return 
                    end

                    InputChanged2 = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Slider.Sliding = false

                            InputChanged2:Disconnect()
                            InputChanged2 = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Slider.Sliding then
                        local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                        local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                        Slider:Set(Value)
                    end
                end
            end)

            Slider:Set(Slider.Default) 

            Library.SetFlags[Slider.Flag] = function(Value)
                Slider:Set(Value)
            end

            return Slider 
        end

        Library.Sections.Dropdown = function(self, Data)
            Data = Data or { }

            local Dropdown = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Dropdown",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Items = Data.Items or Data.items or { },
                Default = Data.Default or Data.default or "",
                Callback = Data.Callback or Data.callback or function() end,
                Multi = Data.Multi or Data.multi or false,

                Value = { },
                Options = { },
                IsOpen = false
            }

            local Items = { }; do 
                Items["Dropdown"] = Instances:Create("Frame", {
                    Parent = Dropdown.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Dropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Dropdown.Name,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["RealDropdown"] = Instances:Create("TextButton", {
                    Parent = Items["Dropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, 0, 0.5, 0),
                    Size = UDim2New(0, 80, 0, 25),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Items["Value"] = Instances:Create("TextLabel", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "...",
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(1, -6, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 6, 0.5, 0),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://135448248851234",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -5, 0.5, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["OptionHolder"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0),
                    Position = UDim2New(1, 0, 0.5, 0),
                    Size = UDim2New(0, 80, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(21, 24, 24)
                })  Items["OptionHolder"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UIStroke", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Color = FromRGB(30, 33, 33),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})
                
                Items["Holder"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.XY,
                    ScrollBarThickness = 2,
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    CanvasSize = UDim2New(0, 0, 0, 0)
                })  Items["Holder"]:AddToTheme({ScrollBarImageColor3 = "Accent"})
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                

                Instances:Create("UIPadding", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    PaddingBottom = UDimNew(0, 4)
                })                
            end

            function Dropdown:Get()
                return Dropdown.Value
            end

            function Dropdown:SetVisibility(Bool)
                Items["Dropdown"].Instance.Visible = Bool
            end

            local Debounce = false
            local RenderStepped

            function Dropdown:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Dropdown.IsOpen = Bool

                Debounce = true 

                if Dropdown.IsOpen then 
                    Items["OptionHolder"].Instance.Visible = true
                    Items["OptionHolder"].Instance.Parent = Library.Holder.Instance
                    
                    RenderStepped = RunService.RenderStepped:Connect(function()
                        Items["OptionHolder"].Instance.Position = UDim2New(0, Items["RealDropdown"].Instance.AbsolutePosition.X, 0, Items["RealDropdown"].Instance.AbsolutePosition.Y - 25)
                        Items["OptionHolder"].Instance.Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, 0)
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if Value ~= Dropdown and not Dropdown.Section.IsSettings then 
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Dropdown] = Dropdown 
                else
                    if Library.OpenFrames[Dropdown] then 
                        Library.OpenFrames[Dropdown] = nil
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end
                end

                local Descendants = Items["OptionHolder"].Instance:GetDescendants()
                TableInsert(Descendants, Items["OptionHolder"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if not TransparencyProperty then
                        continue 
                    end

                    if not Value.ClassName:find("UI") then 
                        Value.ZIndex = Dropdown.IsOpen and 3 or 1
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                    end
                end
                
                NewTween.Tween.Completed:Connect(function()
                    Debounce = false 
                    Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
                    task.wait(0.2)
                    Items["OptionHolder"].Instance.Parent = not Dropdown.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
                end)
            end

            function Dropdown:Set(Option)
                if Dropdown.Multi then 
                    if type(Option) ~= "table" then 
                        return
                    end

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Option do
                        local OptionData = Dropdown.Options[Value]
                         
                        if not OptionData then
                            continue
                        end

                        OptionData.Selected = true 
                        OptionData:Toggle("Active")
                    end

                    Items["Value"].Instance.Text = TableConcat(Option, ", ")
                else
                    if not Dropdown.Options[Option] then
                        return
                    end

                    local OptionData = Dropdown.Options[Option]

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Dropdown.Options do
                        if Value ~= OptionData then
                            Value.Selected = false 
                            Value:Toggle("Inactive")
                        else
                            Value.Selected = true 
                            Value:Toggle("Active")
                        end
                    end

                    Items["Value"].Instance.Text = Option
                end

                if Dropdown.Callback then   
                    Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                end
            end

            function Dropdown:Add(Option)
                local OptionButton = Instances:Create("TextButton", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Option,
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  OptionButton:AddToTheme({BackgroundColor3 = "Accent"})

                local OptionData = {
                    Button = OptionButton,
                    Name = Option,
                    Selected = false
                }
                
                function OptionData:Toggle(Value)
                    if Value == "Active" then
                        OptionData.Button:Tween(nil, {BackgroundTransparency = 0, TextColor3 = FromRGB(0, 0, 0)})
                    else
                        OptionData.Button:Tween(nil, {BackgroundTransparency = 1, TextColor3 = FromRGB(100, 100, 100)})
                    end
                end

                function OptionData:Set()
                    OptionData.Selected = not OptionData.Selected

                    if Dropdown.Multi then 
                        local Index = TableFind(Dropdown.Value, OptionData.Name)

                        if Index then 
                            TableRemove(Dropdown.Value, Index)
                        else
                            TableInsert(Dropdown.Value, OptionData.Name)
                        end

                        OptionData:Toggle(Index and "Inactive" or "Active")

                        Library.Flags[Dropdown.Flag] = Dropdown.Value

                        local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "..."
                        Items["Value"].Instance.Text = TextFormat
                    else
                        if OptionData.Selected then 
                            Dropdown.Value = OptionData.Name
                            Library.Flags[Dropdown.Flag] = OptionData.Name

                            OptionData.Selected = true
                            OptionData:Toggle("Active")

                            for Index, Value in Dropdown.Options do 
                                if Value ~= OptionData then
                                    Value.Selected = false 
                                    Value:Toggle("Inactive")
                                end
                            end

                            Items["Value"].Instance.Text = OptionData.Name
                        else
                            Dropdown.Value = nil
                            Library.Flags[Dropdown.Flag] = nil

                            OptionData.Selected = false
                            OptionData:Toggle("Inactive")

                            Items["Value"].Instance.Text = "..."
                        end
                    end

                    if Dropdown.Callback then
                        Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                    end
                end

                OptionData.Button:Connect("MouseButton1Down", function()
                    OptionData:Set()
                end)

                Dropdown.Options[OptionData.Name] = OptionData
                return OptionData
            end

            function Dropdown:Remove(Option)
                if Dropdown.Options[Option] then
                    Dropdown.Options[Option].Button:Clean()
                    Dropdown.Options[Option] = nil
                end
            end

            function Dropdown:Refresh(List)
                for Index, Value in Dropdown.Options do 
                    Dropdown:Remove(Value.Name)
                end

                for Index, Value in List do 
                    Dropdown:Add(Value)
                end
            end

            Items["RealDropdown"]:Connect("MouseButton1Down", function()
                Dropdown:SetOpen(not Dropdown.IsOpen)
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if Dropdown.IsOpen then
                        if Library:IsMouseOverFrame(Items["OptionHolder"]) then
                            return
                        end

                        Dropdown:SetOpen(false)
                    end
                end
            end)

            Items["RealDropdown"]:Connect("Changed", function(Property)
                if Property == "AbsolutePosition" and Dropdown.IsOpen then
                    Dropdown.IsOpen = not Library:IsClipped(Items["OptionHolder"].Instance, Dropdown.Section.Items["Section"].Instance.Parent)
                    Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
                end
            end)

            for Index, Value in Dropdown.Items do 
                Dropdown:Add(Value)
            end

            if Dropdown.Default then 
                Dropdown:Set(Dropdown.Default)
            end

            Library.SetFlags[Dropdown.Flag] = function(Value)
                Dropdown:Set(Value)
            end

            return Dropdown
        end

        Library.Sections.Label = function(self, Name)
            local Label = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Name or "Label"
            }

            local Items = { }; do
                Items["Label"] = Instances:Create("Frame", {
                    Parent = Label.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 17),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Label.Name,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDimNew(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })      
            end

            function Label:SetText(Text)
               Text = tostring(Text)
               Items["Label"].Instance.Text = Text 
            end

            function Label:SetVisibility(Bool)
                Items["Label"].Instance.Visible = Bool
            end

            function Label:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end
                }

                local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback
                })

                return NewColorpicker
            end

            function Label:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Enum.KeyCode.E,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle"
                }

                local NewKeybind = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end
 
            return Label
        end

        Library.Sections.Textbox = function(self, Data)
            Data = Data or { }

            local Textbox = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or "",
                Callback = Data.Callback or Data.callback or function() end,
                Placeholder = Data.Placeholder or Data.placeholder or "Placeholder",
                Numeric = Data.Numeric or Data.numeric or false,
                Finished = Data.Finished or Data.finished or false,

                Value = ""
            }

            local Items = { }; do 
                Items["Textbox"] = Instances:Create("Frame", {
                    Parent = Textbox.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 25),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Input"] = Instances:Create("TextBox", {
                    Parent = Items["Textbox"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    CursorPosition = -1,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    Size = UDim2New(1, 0, 1, 0),
                    ClipsDescendants = true,
                    BorderSizePixel = 0,
                    PlaceholderColor3 = FromRGB(100, 100, 100),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    PlaceholderText = Textbox.Placeholder,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(30, 34, 34)
                })  Items["Input"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Input"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Input"].Instance,
                    Name = "\0",
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Color = FromRGB(56, 62, 62),
                    Thickness = 2
                }):AddToTheme({Color = "Border 2"})
                
                Instances:Create("UIPadding", {
                    Parent = Items["Input"].Instance,
                    Name = "\0",
                    PaddingLeft = UDimNew(0, 8)
                })                 
            end

            function Textbox:Get()
                return Textbox.Value
            end

            function Textbox:SetVisibility(Bool)
                Items["Textbox"].Instance.Visible = Bool
            end

            function Textbox:Set(Value)
                if Textbox.Numeric then
                    if (not tonumber(Value)) and StringLen(tostring(Value)) > 0 then
                        Value = Textbox.Value
                    end
                end

                Textbox.Value = Value
                Items["Input"].Instance.Text = Value
                Library.Flags[Textbox.Flag] = Value

                if Textbox.Callback then
                    Library:SafeCall(Textbox.Callback, Value)
                end
            end

            if Textbox.Finished then 
                Items["Input"]:Connect("FocusLost", function(PressedEnterQuestionMark)
                    if PressedEnterQuestionMark then
                        Textbox:Set(Items["Input"].Instance.Text)
                    end
                end)
            else
                Items["Input"].Instance:GetPropertyChangedSignal("Text"):Connect(function()
                    Textbox:Set(Items["Input"].Instance.Text)
                end)
            end

            if Textbox.Default then
                Textbox:Set(Textbox.Default)
            end

            Library.SetFlags[Textbox.Flag] = function(Value)
                Textbox:Set(Value)
            end

            return Textbox 
        end
    end

    Library.CreateSettingsPage = function(self, Window)
        local SettingsPage = Window:Page({Name = "Settings", Icon = "72732892493295"}); do 
            local ConfigsSubPage = SettingsPage:SubPage({Name = "Configs"})
            local ThemingSubPage = SettingsPage:SubPage({Name = "Theming"})
            local SettingsSubPage = SettingsPage:SubPage({Name = "Settings"})

            do -- Configs
                local ConfigsSection = ConfigsSubPage:Section({Name = "Configs", Side = 1, Icon = "97491613646216"})

                local ConfigName = ""
                local ConfigSelected

                local ConfigsList = ConfigsSection:Dropdown({
                    Name = "Configs", 
                    Flag = "ConfigsList", 
                    Items = { }, 
                    Multi = false,
                    Callback = function(Value)
                        ConfigSelected = Value
                    end
                })

                ConfigsSection:Textbox({ 
                    Default = "", 
                    Flag = "ConfigName", 
                    Placeholder = "Config name", 
                    Callback = function(Value)
                        ConfigName = Value
                    end
                })

                ConfigsSection:Button({
                    Name = "Create",
                    Callback = function()
                    if ConfigName and ConfigName ~= "" then
                        if not isfile(Library.Folders.Configs .. "/" .. ConfigName .. ".json") then
                            writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())
                            Library:RefreshConfigsList(ConfigsList)
                        else
                            return
                        end
                    end
                end})

                ConfigsSection:Button({
                    Name = "Delete", 
                    Callback = function()
                    if ConfigSelected then
                        Library:DeleteConfig(ConfigSelected)
                        Library:RefreshConfigsList(ConfigsList)
                    end
                end})

                ConfigsSection:Button({
                    Name = "Load", 
                    Callback = function()
                    if ConfigSelected then
                        Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. ConfigSelected))
                    end
                end})

                ConfigsSection:Button({
                    Name = "Save", 
                    Callback = function()
                    if ConfigName and ConfigName ~= "" then
                        writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())
                        Library:RefreshConfigsList(ConfigsList)
                    end
                end})

                ConfigsSection:Button({
                    Name = "Refresh", 
                    Callback = function()
                    Library:RefreshConfigsList(ConfigsList)
                end})

                Library:RefreshConfigsList(ConfigsList)               
            end

            do -- Theming
                local ThemingSection = ThemingSubPage:Section({Name = "Theming", Icon = "131595494666590", Side = 1})
                for Index, Value in Library.Theme do 
                    ThemingSection:Label(Index):Colorpicker({
                        Flag = Index.."Theme",
                        Default = Value,
                        Callback = function(Value)
                            Library.Theme[Index] = Value
                            Library:ChangeTheme(Index, Value)
                        end
                    })
                end
            end

            do -- Settings
                local SettingsSection = SettingsSubPage:Section({Name = "Settings", Icon = "72732892493295", Side = 1})     
                
                SettingsSection:Button({
                    Name = "Unload",
                    Callback = function()
                        Library:Unload()
                    end
                })
                
                SettingsSection:Label("Menu Keybind"):Keybind({
                    Name = "Menu Keybind",
                    Flag = "MenuKeybind",
                    Default = Library.MenuKeybind,
                    Mode = "Toggle",
                    Callback = function()
                        Library.MenuKeybind = Library.Flags["MenuKeybind"].Key
                    end
                })

                SettingsSection:Slider({
                    Name = "Tween Speed",
                    Default = 0.3,
                    Flag = "Tween Speed",
                    Decimals = 0.01,
                    Suffix = "s",
                    Max = 10,
                    Min = 0,
                    Callback = function(Value)
                        Library.Tween.Time = Value
                    end
                })

                SettingsSection:Dropdown({
                    Name = "Tween Style",
                    Flag = "Tween style",
                    Items = { "Linear", "Quad", "Quart", "Back", "Bounce", "Circular", "Cubic", "Elastic", "Exponential", "Sine", "Quint" },
                    Default = "Quart",
                    Callback = function(Value)
                        if not Value then Value = "Quint" end
                        Library.Tween.Style = Enum.EasingStyle[Value]
                    end
                })

                SettingsSection:Dropdown({
                    Name = "Tween Direction",
                    Flag = "Tween direction",
                    Items = { "In", "Out", "InOut" },
                    Default = "Out",
                    Callback = function(Value)
                        if not Value then Value = "Out" end
                        Library.Tween.Direction = Enum.EasingDirection[Value]
                    end
                })
            end
        end
    end
end

getgenv().Library = Library
end

-- ================= OPERATION ONE — MENU + FEATURES (Samet UI) =================
-- Requires the Samet UI library loaded first (getgenv().Library).
local Library = getgenv().Library
if not Library then
	return warn("[OP1] UI library not loaded — run library.luau first.")
end

-- Tear down the previous execution in this session BEFORE installing anything
-- new. Old RenderStepped connections, Drawing objects, GUIs and hooks otherwise
-- pile up on every re-run and freeze the game.
pcall(function()
	local prev = getgenv().__op1Clean
	if prev then prev() end
end)

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local WS = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local CG = game:GetService("CoreGui")
local CS = game:GetService("CollectionService")
local LP = Players.LocalPlayer

local S = {
	noSpread = false,
	noRecoil = false,
	silentAim = false,
	autoFire = false,
	teamCheck = true,
	hideFrozen = true, -- anti-ghost: hide viewmodels that haven't moved for a while
	drawEsp = false,
	drawBox = true,
	drawHealth = true,
	drawName = true,
	drawTracer = true,
	gunEsp = true,
	gunEspColor = Color3.fromRGB(255, 170, 0),
	espColor = Color3.fromRGB(255, 255, 255),
	espTeamColor = Color3.fromRGB(80, 160, 255),
	autoSkipLoading = false, -- auto-hide the game's Loading GUI if it gets stuck
	saWallbang = false,   -- allow wallbangable targets (overrides visible when on)
	saVisible = true,     -- require line of sight
	fovCheck = true,      -- only target enemies inside the FOV circle
	fov = 300,            -- radius in pixels
	priority = "Crosshair", -- "Crosshair" | "Nearest"
	maxAngle = 45,        -- degrees: only aim at enemies within this cone of your crosshair (plausibility)
	overwrite = false,    -- while the overwrite key is held, target any vis/wb enemy (ignores FOV + checks)
	enemyPanel = true,
	skeleton = false,
	skeletonColor = Color3.fromRGB(255, 64, 64),
	skeletonThickness = 1.5,
	boxEsp = false,
	boxColor = Color3.fromRGB(255, 64, 64),
	boxTeamColor = Color3.fromRGB(74, 222, 128),
	boxThickness = 1.5,
	boxFill = false,
	deviceEsp = false,
	deviceColor = Color3.fromRGB(255, 170, 0),
	-- bullet tracers
	bulletTracers = false,
	tracerColor = Color3.fromRGB(255, 255, 255),
	tracerThickness = 0.15,
	tracerLifetime = 1.5,
    manip = false,
    manipKeyHeld = false,
    manipDist = 4.5,
    manipAutoFire = true,
	hitmarker = false,
	hitmarkerColor = Color3.fromRGB(255, 255, 255),
	hitmarkerSize = 32,
	hitmarkerDuration = 0.35,
	-- ragebot
	rbEnabled = false,
	rbAutoShoot = false,
	rbAutoWallbang = false,
	rbAutoWB = false,
	rbMinDmg = 20,
	rbPriority = "Crosshair",
	rbFOV = 300,
	rbVisualCheck = true,
	rbTargetPart = "Auto",
	rbAutoStop = false,
	rbAutoCrouch = false,
	dummyDistance = 15,
	thirdPerson = false,
	tpDistance = 12,
	tpHeight = 2,
	fpLock = false,
	fpMaxPitch = 85,
    -- force-grapple fly
    flyEnabled = false,
    flySpeed = 60,              -- studs/sec
    flyVerticalSpeed = 40,      -- studs/sec
    flyAnchorRefresh = true,    -- re-snap the anchor every frame (steers the motion)
    flyAutoCreateHook = true,   -- synthesize a valid hook CFrame if none exists
	}

-- ===========================================================================
-- Noclip collision groups (register both, non-colliding against everything)
-- ===========================================================================
local PhysicsService = game:GetService("PhysicsService")

pcall(function()
    PhysicsService:RegisterCollisionGroup("OP1_Noclip_A")
    PhysicsService:RegisterCollisionGroup("OP1_Noclip_B")
    for _, other in ipairs({
        "Default", "char", "wall", "floor", "char_anim",
        "thrown", "prop", "char_block", "dropped", "weak",
        "ragdoll", "sound"
    }) do
        pcall(function()
            PhysicsService:CollisionGroupSetCollidable("OP1_Noclip_A", other, false)
            PhysicsService:CollisionGroupSetCollidable("OP1_Noclip_B", other, false)
        end)
    end
end)

-- ===========================================================================
-- CollisionGroup property hook: swallow the game's writes to collision.CollisionGroup
-- while noclip is on. Prevents the flick that comes from periodic game writes.
-- ===========================================================================
do
    local mt = getrawmetatable(game)
    -- Re-uses the TRUE originals across executions so the hook never stacks.
    -- (Stacking a new wrapper around the previous wrapper on every re-run made
    --  every property write / namecall in the game traverse N closure layers.)
    local saved = getgenv().__op1_cgOrig
    if not saved then
        saved = { newindex = mt.__newindex, namecall = mt.__namecall }
        getgenv().__op1_cgOrig = saved
    end
    local oldNewIndex = saved.newindex
    local oldNamecall = saved.namecall

    setreadonly(mt, false)
    mt.__newindex = oldNewIndex
    mt.__namecall = oldNamecall

    -- property write hook: instance.CollisionGroup = value
    mt.__newindex = newcclosure(function(self, key, value)
        if key == "CollisionGroup" then
            -- S and noclip flag are upvalues; S is in scope because we're in the same chunk
            if S and S.noclipEnabled then
                local n = self and self.Name
                if n == "collision" or n == "HumanoidRootPart" then
                    -- swallow writes to char / char_anim / Default while noclip is on
                    if value == "char" or value == "char_anim" or value == "Default" then
                        return
                    end
                end
            end
        end
        return oldNewIndex(self, key, value)
    end)

    -- namecall hook: SetCollisionGroup-style methods if the game uses them
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "SetCollisionGroup" then
            if S and S.noclipEnabled then
                local n = self and self.Name
                if n == "collision" or n == "HumanoidRootPart" then
                    local v = ...
                    if v == "char" or v == "char_anim" or v == "Default" then
                        return
                    end
                end
            end
        end
        return oldNamecall(self, ...)
    end)

    setreadonly(mt, true)
    getgenv().__op1_cgHooked = true
    print("[OP1] CollisionGroup hook installed")
end

-- Disconnect leftovers from ANY previous execution in this session.
-- Without this, every re-run added ~20 more live RenderStepped/Input connections
-- that were never disconnected -- after a few test runs the game froze.
local prevConns = getgenv().__op1Conns
if prevConns then
    for _, c in ipairs(prevConns) do pcall(function() c:Disconnect() end) end
    for i = #prevConns, 1, -1 do prevConns[i] = nil end
end
local conns = {}
getgenv().__op1Conns = conns
local savedGunVals = {}
local function track(c) conns[#conns + 1] = c; return c end

local UIS = game:GetService("UserInputService")
track(UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.R then
		local ch = LP.Character
		local item = ch and ch:FindFirstChild("equipped") and ch.equipped.Value
		local gun = item and item:FindFirstChild("Gun")
		if gun then
			-- Force reload by setting loaded=true and mag to max
			local loaded = gun:FindFirstChild("loaded")
			local mag = gun:FindFirstChild("mag")
			local maxMag = gun:FindFirstChild("max_mag")
			if loaded then loaded.Value = true end
			if maxMag and mag then mag.Value = maxMag.Value end
		end
	end
end))

local silentAimUninstall = nil
local silentAimInstalled = false
local cleanupDraw = nil


local function cleanup()
	for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
	for i = #conns, 1, -1 do conns[i] = nil end
	-- restore original metatable hooks (undo the CollisionGroup hook)
	pcall(function()
		local saved = getgenv().__op1_cgOrig
		if saved then
			local mt = getrawmetatable(game)
			setreadonly(mt, false)
			mt.__newindex = saved.newindex
			mt.__namecall = saved.namecall
			setreadonly(mt, true)
			getgenv().__op1_cgOrig = nil
			getgenv().__op1_cgHooked = false
		end
	end)
	pcall(function() WS:SetAttribute("__op1_noSpread", false) end) -- before uninstall so the hook restores spread values
	pcall(function() if silentAimUninstall then silentAimUninstall() end end)
	pcall(function() if cleanupDraw then cleanupDraw() end end)
    if getgenv().__op1_fgStop then pcall(getgenv().__op1_fgStop) end
    if getgenv().__op1_unapplyNoclip then pcall(getgenv().__op1_unapplyNoclip) end
    S.flyEnabled = false
    S.noclipEnabled = false
	-- Reset peekbot state
	for _, name in ipairs({ "OP1_EnemyPanel", "OP1_FOV", "OP1_Skeleton", "OP1_Boxes", "OP1_Devices", "OP1_Hitmarker" }) do
		pcall(function()
			local cg = game:GetService("CoreGui")
			for _, c in ipairs(cg:GetChildren()) do
				if c.Name == name then c:Destroy() end
			end
		end)
	end
	getgenv().__piPanel = nil
	for _, n in ipairs({ "OP1_SpinLook", "OP1_SpinCam", "OP1_Spin", "OP1_ThirdPerson", "OP1_FPLock", "OP1_PeekCam" }) do
		pcall(function() RunService:UnbindFromRenderStep(n) end)
	end
	pcall(function() RunService:UnbindFromRenderStep("OP1_Noclip") end)
	pcall(function() local c = LP.Character; local h = c and c:FindFirstChildOfClass("Humanoid"); if h then h.AutoRotate = true end end)
	pcall(function() local d = WS:FindFirstChild("OP1_Dummies"); if d then d:Destroy() end end)
	pcall(function() local b = WS:FindFirstChild("OP1_TPBody"); if b then b:Destroy() end end)
	pcall(function() local m = WS:FindFirstChild("OP1_Morph"); if m then m:Destroy() end end)
	pcall(function() WS:SetAttribute("__op1_saOn", false) end)
	pcall(function() WS:SetAttribute("__op1_saOverwrite", false) end)
	pcall(function() WS:SetAttribute("__op1_manipOn", false) end)
	for part, v in pairs(savedGunVals) do
		if part.Parent then pcall(function() part.Value = v end) end
	end
	savedGunVals = {}
end
getgenv().__op1Clean = cleanup
-- cleanup()  -- removed: was running immediately on load, causing freeze

-- helper: push combat settings to the actor via workspace attributes
local function pushSettings()
	WS:SetAttribute("__op1_saWallbang", S.saWallbang)
	WS:SetAttribute("__op1_saVisible", S.saVisible)
	WS:SetAttribute("__op1_saFOVCheck", S.fovCheck)
	WS:SetAttribute("__op1_saFOV", S.fov)
	WS:SetAttribute("__op1_saTeam", S.teamCheck)
	WS:SetAttribute("__op1_saPriority", S.priority)
	WS:SetAttribute("__op1_saMaxAngle", S.maxAngle)
    WS:SetAttribute("__op1_manipOn", S.manip == true and S.manipKeyHeld == true)
    WS:SetAttribute("__op1_manipDist", S.manipDist or 4.5)
	-- ragebot settings
	WS:SetAttribute("__op1_rbEnabled", S.rbEnabled)
	WS:SetAttribute("__op1_rbAutoShoot", S.rbAutoShoot)
	WS:SetAttribute("__op1_rbAutoWallbang", S.rbAutoWallbang)
	WS:SetAttribute("__op1_rbAutoWB", S.rbAutoWB)
	WS:SetAttribute("__op1_rbMinDmg", S.rbMinDmg)
	WS:SetAttribute("__op1_rbPriority", S.rbPriority)
	WS:SetAttribute("__op1_rbFOV", S.rbFOV)
	WS:SetAttribute("__op1_rbAutoStop", S.rbAutoStop)
	WS:SetAttribute("__op1_rbAutoCrouch", S.rbAutoCrouch)
	WS:SetAttribute("__op1_rbTargetPart", S.rbTargetPart)
end
pushSettings()

-- ===========================================================================
-- FEATURE: No Spread / No Recoil (viewmodel gun + item gun)
-- ===========================================================================
local function getGuns()
	local list = {}
	local lvm = WS:FindFirstChild("Viewmodels")
	if lvm then
		local localvm = lvm:FindFirstChild("LocalViewmodel")
		if localvm then
			for _, c in ipairs(localvm:GetChildren()) do
				local g = c:FindFirstChild("Gun")
				if g then list[#list + 1] = g end
			end
		end
	end
	local ch = LP.Character
	local cfg = ch and ch:FindFirstChild("Character")
	local item = cfg and cfg:FindFirstChild("equipped") and cfg.equipped.Value
	local igun = item and item:FindFirstChild("Gun")
	if igun then list[#list + 1] = igun end
	return list
end
track(RunService.RenderStepped:Connect(function()
	for _, g in ipairs(getGuns()) do
		for name, on in pairs({ spread = S.noSpread, recoil_up = S.noRecoil, recoil_side = S.noRecoil }) do
			local v = g:FindFirstChild(name)
			if v and v:IsA("NumberValue") then
				if on then
					if savedGunVals[v] == nil then savedGunVals[v] = v.Value end
					v.Value = 0
				elseif savedGunVals[v] ~= nil then
					v.Value = savedGunVals[v]; savedGunVals[v] = nil
				end
			end
		end
	end
end))

-- ===========================================================================
-- shared combat helpers (main thread)
-- ===========================================================================
local visParams = RaycastParams.new(); visParams.FilterType = Enum.RaycastFilterType.Exclude
local function getIgnore()
	local ig = {}
	if LP.Character then ig[#ig + 1] = LP.Character end
	local vm = WS:FindFirstChild("Viewmodels")
	if vm then local l = vm:FindFirstChild("LocalViewmodel"); if l then ig[#ig + 1] = l end end
	return ig
end
local function penetrable(part)
	local par = part.Parent
	local hard = part:GetAttribute("Hard") or (par and par:GetAttribute("Hard"))
	local soft = part:GetAttribute("Soft") or (par and par:GetAttribute("Soft"))
	local solidNonSoft = (not soft) and part.CanCollide == true and part.Transparency < 1
	if hard or solidNonSoft then
		local s = { part.Size.X, part.Size.Y, part.Size.Z }; table.sort(s)
		if s[2] < 1.45 and ((not part:HasTag("WallPart") and not hard) or s[2] <= 0.5) then return true end
		return false
	end
	return true
end
local function rayStatus(head, model, ignore)
	local cam = WS.CurrentCamera
	if not cam then return nil end
	local last = cam.CFrame.Position
	visParams.FilterDescendantsInstances = ignore or {}
	local layers = 0
	for _ = 1, 20 do
		local dir = head.Position - last
		if dir.Magnitude < 0.2 then return layers == 0 and "vis" or "wb" end
		local r = WS:Raycast(last, dir, visParams)
		if not r then return layers == 0 and "vis" or "wb" end
		local inst = r.Instance
		if inst == head or (model and inst.Parent == model) then return layers == 0 and "vis" or "wb" end
		visParams:AddToFilter(inst)
		if not penetrable(inst) then return nil end
		layers = layers + 1; last = r.Position + dir.Unit * 0.05
	end
	return nil
end
-- helper to check if a player is on the local player's team
local function isTeammate(target)
	if not target then return false end
	local plr = target
	if typeof(target) == "table" then
		if target.isDummy then return false end
		plr = target.plr
	end
	if not plr or plr == LP or typeof(plr) ~= "Instance" then return false end

	-- 1. Roblox Team object comparison
	if LP.Team ~= nil and plr.Team ~= nil then
		return plr.Team == LP.Team
	end

	-- 2. "Team" Attribute string comparison
	local lpAttr = LP:GetAttribute("Team")
	local pAttr = plr:GetAttribute("Team")
	if lpAttr ~= nil and pAttr ~= nil and lpAttr ~= "Spectate" then
		return pAttr == lpAttr
	end

	return false
end

-- check if a character model has a gun (players always have a gun)
local function hasGun(player, model)
	if not model then return false end
	if model:FindFirstChild("Gun") or model:FindFirstChildWhichIsA("Tool") then
		return true
	end
	local cfg = model:FindFirstChild("Character")
	if cfg then
		local eq = cfg:FindFirstChild("equipped")
		if eq and eq.Value then return true end
		local hold = cfg:FindFirstChild("holding")
		if hold and hold.Value then return true end
	end
	local directEq = model:FindFirstChild("equipped") or model:FindFirstChild("holding")
	if directEq and directEq.Value then return true end
	if model:FindFirstChild("Gun", true) or model:FindFirstChild("Muzzle", true) or model:FindFirstChild("muzzle", true) then
		return true
	end
	if player then
		for _, ch in ipairs({model, player.Character}) do
			if ch then
				local c = ch:FindFirstChild("Character")
				if c then
					local eq = c:FindFirstChild("equipped")
					local item = eq and eq.Value
					if item and item.Name ~= "" then return true end
					local hold = c:FindFirstChild("holding")
					local hv = hold and hold.Value
					if hv and hv.Name ~= "" then return true end
				end
			end
		end
	end
	return false
end

-- link a player to its character: workspace model (handles custom avatars/morphs & workspace models with guns)
local function findCharacter(player)
	if not player then return nil end

	-- 1. Check player.Character directly if it is in Workspace and alive with a gun
	local ch = player.Character
	if ch and ch:IsDescendantOf(WS) then
		local hum = ch:FindFirstChildOfClass("Humanoid")
		local root = ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart or ch:FindFirstChild("Torso") or ch:FindFirstChild("UpperTorso") or ch:FindFirstChild("Head")
		if hum and root and hum.Health > 0 and hasGun(player, ch) then
			return ch, hum, root
		end
	end

	-- 2. Search workspace:GetChildren() for a Model named after player
	for _, model in ipairs(WS:GetChildren()) do
		if model:IsA("Model") and model.Name == player.Name then
			local hum = model:FindFirstChildOfClass("Humanoid")
			local root = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("Head")
			if hum and root and hum.Health > 0 and hasGun(player, model) then
				return model, hum, root
			end
		end
	end

	-- 3. Search workspace for any character model associated with player via Attribute/Value
	for _, model in ipairs(WS:GetChildren()) do
		if model:IsA("Model") then
			local pVal = model:FindFirstChild("Player") or model:GetAttribute("Player")
			if pVal and (pVal == player or pVal == player.Name) then
				local hum = model:FindFirstChildOfClass("Humanoid")
				local root = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("Head")
				if hum and root and hum.Health > 0 and hasGun(player, model) then
					return model, hum, root
				end
			end
		end
	end

	return nil
end
local playerChar = findCharacter
-- anti-stuck: hide viewmodels whose position hasn't moved for a while (frozen "ghosts")
local ghostTrack = {}
local function isFrozen(vm, pos)
	if not S.hideFrozen then return false end
	local t = ghostTrack[vm]
	if not t then ghostTrack[vm] = { pos = pos, time = os.clock() }; return false end
	if (pos - t.pos).Magnitude > 0.6 then t.pos = pos; t.time = os.clock(); return false end
	return (os.clock() - t.time) > 1.5
end
-- map each viewmodel -> { team, alive } via one-to-one nearest match to a LIVE player character
local function buildVMMap()
	local map = {}
	local vm = WS:FindFirstChild("Viewmodels")
	if not vm then return map end
	local vms = {}
	for _, c in ipairs(vm:GetChildren()) do
		if c.Name ~= "LocalViewmodel" and c:IsA("Model") then
			local h = c:FindFirstChild("head") or c:FindFirstChild("torso")
			if h then vms[#vms + 1] = { vm = c, pos = h.Position } end
		end
	end
	local plrs = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP then
			local ch, hum, root = playerChar(p)
			if ch and hum and root and hum.Health > 0 then
				plrs[#plrs + 1] = { plr = p, pos = root.Position, hum = hum }
			end
		end
	end
	local cand = {}
	for i, v in ipairs(vms) do
		for j, q in ipairs(plrs) do
			local d = (v.pos - q.pos).Magnitude
			if d < 8 then cand[#cand + 1] = { i = i, j = j, d = d } end
		end
	end
	table.sort(cand, function(a, b) return a.d < b.d end)
	local usedVm, usedPlr = {}, {}
	for _, c in ipairs(cand) do
		if not usedVm[c.i] and not usedPlr[c.j] then
			if not isFrozen(vms[c.i].vm, vms[c.i].pos) then
				usedVm[c.i] = true; usedPlr[c.j] = true
				map[vms[c.i].vm] = { team = plrs[c.j].plr:GetAttribute("Team"), alive = true, plr = plrs[c.j].plr, hum = plrs[c.j].hum }
			end
		end
	end
	return map
end
-- targetability: wallbang overrides visible
local function targetable(status)
	-- ragebot Auto Wallbang makes penetrable ("wb") targets eligible; otherwise the Aim
	-- section's own Wallbang / Visible Check toggles decide (they used to be force-overwritten
	-- whenever ragebot was enabled, which left them silently stuck after disabling it)
	if S.saWallbang or (S.rbEnabled and (S.rbAutoWallbang or S.rbAutoWB)) then return status ~= nil end
	if S.saVisible then return status == "vis" end
	return true                                     -- both off: any target, incl. fully blocked
end
-- opt.noTeam = include our own team as well (Box ESP draws them in the team colour;
-- targeting callers keep the Team Check behaviour)
local function getEnemies(opt)
	local list, n = {}, 0
	local vmRoot = WS:FindFirstChild("Viewmodels")
	local vms = {}
	if vmRoot then
		for _, c in ipairs(vmRoot:GetChildren()) do
			if c.Name ~= "LocalViewmodel" and c:IsA("Model") then
				local h = c:FindFirstChild("head") or c:FindFirstChild("torso")
				if h and not isFrozen(c, h.Position) then vms[#vms + 1] = { vm = c, used = false } end
			end
		end
	end
	local function vmHead(m) return m and (m:FindFirstChild("head") or m:FindFirstChild("torso")) end
	-- source of truth = players + their characters (never misses); attach nearest viewmodel for skeletons
	local lpTeam = LP:GetAttribute("Team")
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP then
			local ch, hum, root = findCharacter(p)
			if ch and hum and root and hum.Health > 0 then
				local teamSame = isTeammate(p)
				local t = p.Team and p.Team.Name or p:GetAttribute("Team")
				if t ~= "Spectate" and ((opt and opt.noTeam == true) or not (S.teamCheck and teamSame)) then
					local best, bestD = nil, math.huge
					for _, v in ipairs(vms) do
						if not v.used then
							local h = vmHead(v.vm)
							if h then
								local d = (h.Position - root.Position).Magnitude
								if d < bestD then bestD, best = d, v end
							end
						end
					end
					local model, head
					if best and bestD < 40 then
						best.used = true
						model = best.vm
						head = vmHead(model) or root
					else
						head = root
					end
					n = n + 1
					list[#list + 1] = { model = model, head = head, char = ch, plr = p, name = p.Name, teamSame = teamSame and true or false, isDummy = false, health = hum.Health, maxHealth = hum.MaxHealth }
				end
			end
		end
	end
	local df = WS:FindFirstChild("OP1_Dummies")
	if df then
		for _, c in ipairs(df:GetChildren()) do
			if c:IsA("Model") then
				local h = c:FindFirstChild("head") or c:FindFirstChild("torso")
				if h then
					n = n + 1
					list[#list + 1] = { model = c, head = h, name = "Dummy " .. n, teamSame = false, isDummy = true }
				end
			end
		end
	end
	return list
end
-- ===========================================================================
-- FEATURE: Test dummies (spawn an enemy replica in front of you for ESP testing)
-- ===========================================================================
local dummyFolder = WS:FindFirstChild("OP1_Dummies")
if not dummyFolder then
	dummyFolder = Instance.new("Folder"); dummyFolder.Name = "OP1_Dummies"; dummyFolder.Parent = WS
end
local function spawnDummy()
	local vmRoot = WS:FindFirstChild("Viewmodels")
	local template
	if vmRoot then
		for _, c in ipairs(vmRoot:GetChildren()) do
			if c:IsA("Model") and c.Name ~= "LocalViewmodel" and c:FindFirstChild("head") then template = c break end
		end
		if not template then
			local lvm = vmRoot:FindFirstChild("LocalViewmodel")
			if lvm and lvm:FindFirstChild("head") then template = lvm end
		end
	end
	if not template then return false, "no viewmodel template found" end
	local cam = WS.CurrentCamera
	if not cam then return false, "no camera" end
	local ok, err = pcall(function()
		local clone = template:Clone()
		clone.Name = "OP1_Dummy"
		clone:SetAttribute("__op1_dummy", true)
		for _, p in ipairs(clone:GetDescendants()) do
			if p:IsA("BasePart") then
				p.Anchored = true; p.CanCollide = false; p.CanQuery = false; p.CanTouch = false
			end
		end
		local ig = { clone }
		if LP.Character then ig[#ig + 1] = LP.Character end
		if vmRoot then local lvm = vmRoot:FindFirstChild("LocalViewmodel"); if lvm then ig[#ig + 1] = lvm end end
		local rp = RaycastParams.new(); rp.FilterType = Enum.RaycastFilterType.Exclude
		rp.FilterDescendantsInstances = ig
		local char = LP.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local origin = root and root.Position or cam.CFrame.Position
		local dir = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
		if dir.Magnitude < 0.01 then dir = Vector3.new(0, 0, 1) end
		dir = dir.Unit
		local base = origin + dir * S.dummyDistance
		clone.Parent = dummyFolder
		-- find the floor under the target spot; start at body height so we don't hit a ceiling
		local rayStart = Vector3.new(base.X, origin.Y + 1, base.Z)
		local hit = WS:Raycast(rayStart, Vector3.new(0, -300, 0), rp)
		local groundY = hit and hit.Position.Y or (rayStart.Y - 3)
		clone:PivotTo(CFrame.lookAt(Vector3.new(base.X, groundY + 10, base.Z), Vector3.new(origin.X, groundY + 10, origin.Z)))
		local low = math.huge
		for _, p in ipairs(clone:GetDescendants()) do
			if p:IsA("BasePart") then low = math.min(low, p.Position.Y) end
		end
		if low ~= math.huge then clone:PivotTo(clone:GetPivot() + Vector3.new(0, groundY - low, 0)) end
	end)
	if not ok then return false, tostring(err) end
	return true
end
local function clearDummies()
	if not dummyFolder then return end
	for _, c in ipairs(dummyFolder:GetChildren()) do c:Destroy() end
end
-- Target Part: which body part the aim hook / autofire / tracers actually point at
local aimPartNames = {
	Head = { "head", "Head" },
	Torso = { "torso", "Torso", "UpperTorso" },
	LowerTorso = { "lower_torso", "LowerTorso" },
	HumanoidRootPart = { "HumanoidRootPart" },
}
local function aimPartOf(e)
	local want = S.rbTargetPart
	local ch = e.char or e.model
	if want and want ~= "Auto" and ch then
		local names = aimPartNames[want]
		if names then
			for _, n in ipairs(names) do
				local p = ch:FindFirstChild(n)
				if p and p:IsA("BasePart") then return p end
			end
		end
	end
	return e.head
end
-- Screen-space FOV allowance must track the camera zoom: when the gun scopes in,
-- the camera FOV shrinks, so the same off-axis angle covers MORE pixels and would
-- otherwise fall outside a fixed-pixel circle. Scaling by the tan ratio keeps the
-- allowance angular, so scoped or not a target sits at the same spot in the circle.
local function fovScaleFor(cam)
	local base = cam:GetAttribute("OriginalFOV")
	if not base or base <= 0 or not cam.FieldOfView or cam.FieldOfView <= 0 then return 1 end
	local t1 = math.tan(math.rad(base) * 0.5)
	local t2 = math.tan(math.rad(cam.FieldOfView) * 0.5)
	if not (t1 > 0) or not (t2 > 0) then return 1 end
	local s = t1 / t2
	if not (s > 0) or s ~= s then return 1 end
	return s
end
-- returns list of {enemy, screenPos, dist, status} that pass team + targetability + fov
-- opt.noFov = ignore the Aim section's FOV circle (ragebot has its own Max FOV)
local function getTargets(opt)
	local cam = WS.CurrentCamera
	if not cam then return {} end
	local vp = cam.ViewportSize
	local mouse = Vector2.new(vp.X * 0.5, vp.Y * 0.5)
	local ignore = getIgnore()
	local fovScale = fovScaleFor(cam)
	local noFov = opt ~= nil and opt.noFov == true
	local out = {}
	for _, e in ipairs(getEnemies()) do
		local aim = aimPartOf(e)
		local status = rayStatus(aim, e.model, ignore)
		if targetable(status) then
			local sp = cam:WorldToViewportPoint(aim.Position)
			if sp.Z > 0 then
				local dx, dy = sp.X - mouse.X, sp.Y - mouse.Y
				local d = math.sqrt(dx * dx + dy * dy)
				local okFov = noFov or (not S.fovCheck) or d <= S.fov * fovScale
				local okAngle = true
				if S.maxAngle < 180 then
					local dir = aim.Position - cam.CFrame.Position
					okAngle = dir.Magnitude > 0.001 and math.deg(math.acos(math.clamp(dir.Unit:Dot(cam.CFrame.LookVector), -1, 1))) <= S.maxAngle
				end
				if okFov and okAngle then
					out[#out + 1] = { e = e, sp = sp, dist = d, status = status, aim = aim }
				end
			end
		end
	end
	table.sort(out, function(a, b) return a.dist < b.dist end)
	return out
end

-- ===========================================================================
-- FEATURE: Enemy panel (top-left, toggleable) + FOV circle
-- ===========================================================================
if getgenv().__piPanel then pcall(function() getgenv().__piPanel:Destroy() end) end
local panelGui = Instance.new("ScreenGui")
panelGui.Name = "OP1_EnemyPanel"; panelGui.ResetOnSpawn = false; panelGui.DisplayOrder = 998; panelGui.Parent = CG
getgenv().__piPanel = panelGui
local panel = Instance.new("Frame")
panel.Position = UDim2.new(0, 10, 0, 10); panel.Size = UDim2.fromOffset(196, 40)
panel.BackgroundColor3 = Color3.fromRGB(20, 21, 28); panel.BackgroundTransparency = 0.15; panel.BorderSizePixel = 0; panel.Parent = panelGui
local pc = Instance.new("UICorner"); pc.CornerRadius = UDim.new(0, 8); pc.Parent = panel
local pStroke = Instance.new("UIStroke"); pStroke.Color = Color3.fromRGB(58, 61, 80); pStroke.Parent = panel
local pTitle = Instance.new("TextLabel")
pTitle.Size = UDim2.new(1, -20, 0, 26); pTitle.Position = UDim2.new(0, 12, 0, 6); pTitle.BackgroundTransparency = 1
pTitle.Font = Enum.Font.GothamBold; pTitle.TextSize = 13; pTitle.TextColor3 = Color3.fromRGB(233, 235, 245)
pTitle.TextXAlignment = Enum.TextXAlignment.Left; pTitle.Text = "ENEMIES"; pTitle.Parent = panel
local listFrame = Instance.new("Frame")
listFrame.Position = UDim2.new(0, 10, 0, 32); listFrame.Size = UDim2.new(1, -20, 0, 0); listFrame.BackgroundTransparency = 1; listFrame.Parent = panel
local panelList = Instance.new("UIListLayout")
panelList.Padding = UDim.new(0, 3); panelList.SortOrder = Enum.SortOrder.LayoutOrder; panelList.Parent = listFrame
local rows = {}
local function row(i)
	if rows[i] then return rows[i] end
	local r = Instance.new("Frame"); r.Size = UDim2.new(1, 0, 0, 18); r.BackgroundTransparency = 1; r.LayoutOrder = i; r.Parent = listFrame
	local name = Instance.new("TextLabel"); name.Size = UDim2.new(0.62, 0, 1, 0); name.BackgroundTransparency = 1
	name.Font = Enum.Font.Gotham; name.TextSize = 11; name.TextColor3 = Color3.fromRGB(233, 235, 245)
	name.TextXAlignment = Enum.TextXAlignment.Left; name.TextTruncate = Enum.TextTruncate.AtEnd; name.Parent = r
	local badge = Instance.new("TextLabel"); badge.Position = UDim2.new(0.62, 0, 0, 0); badge.Size = UDim2.new(0.38, 0, 1, 0)
	badge.BackgroundTransparency = 1; badge.Font = Enum.Font.GothamBold; badge.TextSize = 11
	badge.TextXAlignment = Enum.TextXAlignment.Right; badge.Parent = r
	rows[i] = { frame = r, name = name, badge = badge }
	return rows[i]
end

-- FOV circle gui
local fovGui = Instance.new("ScreenGui")
fovGui.Name = "OP1_FOV"; fovGui.ResetOnSpawn = false; fovGui.DisplayOrder = 996; fovGui.IgnoreGuiInset = true; fovGui.Parent = CG
local fovCircle = Instance.new("Frame")
fovCircle.BackgroundTransparency = 1; fovCircle.BorderSizePixel = 0; fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
fovCircle.Visible = false; fovCircle.Parent = fovGui
local fovCorner = Instance.new("UICorner"); fovCorner.CornerRadius = UDim.new(1, 0); fovCorner.Parent = fovCircle
local fovStroke = Instance.new("UIStroke"); fovStroke.Thickness = 1.5; fovStroke.Color = Color3.fromRGB(99, 102, 241); fovStroke.Parent = fovCircle

-- Skeleton ESP gui + bones
local skelGui = Instance.new("ScreenGui")
skelGui.Name = "OP1_Skeleton"; skelGui.ResetOnSpawn = false; skelGui.DisplayOrder = 994; skelGui.IgnoreGuiInset = true; skelGui.Parent = CG
local function skelHas(model, n)
	local p = model:FindFirstChild(n)
	if p and p:IsA("BasePart") then return p end
	return nil
end
-- edge-to-edge bones -> limbs connect flush (no crossing lines)
local function partEnds(p)
	local cf = p.CFrame
	local h = p.Size.Y * 0.5
	return (cf * CFrame.new(0, h, 0)).Position, (cf * CFrame.new(0, -h, 0)).Position
end
local function skelWorldSegments(model)
	local segs = {}
	local torso = skelHas(model, "torso")
	if not torso then return segs end
	local tTop = (torso.CFrame * CFrame.new(0, torso.Size.Y * 0.5, 0)).Position
	local tBot = (torso.CFrame * CFrame.new(0, -torso.Size.Y * 0.5, 0)).Position
	local head = skelHas(model, "head")
	if head then
		local _, hb = partEnds(head)
		segs[#segs + 1] = { hb, tTop }
	end
	local function limb(joint, leaf, attach)
		local jp = skelHas(model, joint)
		local lp = skelHas(model, leaf)
		local prev = attach
		if jp then
			local a, b = partEnds(jp)
			if (a - prev).Magnitude > (b - prev).Magnitude then a, b = b, a end
			segs[#segs + 1] = { prev, a }; prev = b
		end
		if lp then
			local a, b = partEnds(lp)
			if (a - prev).Magnitude > (b - prev).Magnitude then a, b = b, a end
			segs[#segs + 1] = { prev, a }; segs[#segs + 1] = { a, b }
		end
	end
	limb("shoulder1", "arm1", tTop)
	limb("shoulder2", "arm2", tTop)
	limb("hip1", "leg1", tBot)
	limb("hip2", "leg2", tBot)
	return segs
end
local skelLines = {}
local function skelLine(model, i)
	local set = skelLines[model]
	if not set then set = {}; skelLines[model] = set end
	if set[i] then return set[i] end
	local f = Instance.new("Frame")
	f.BorderSizePixel = 0; f.AnchorPoint = Vector2.new(0, 0.5); f.Visible = false; f.Parent = skelGui
	set[i] = f
	return f
end
track(RunService.RenderStepped:Connect(function()
	if not S.skeleton then
		for _, set in pairs(skelLines) do for _, f in ipairs(set) do f.Visible = false end end
		return
	end
	local cam = WS.CurrentCamera
	if not cam then return end
	local enemies = getEnemies()
	local alive = {}
	for _, e in ipairs(enemies) do
		if not e.model then continue end
		alive[e.model] = true
		local segs = skelWorldSegments(e.model)
		local ok = (#segs > 0)
		if ok then
			for i, s in ipairs(segs) do
				local va = cam:WorldToViewportPoint(s[1])
				local vb = cam:WorldToViewportPoint(s[2])
				local f = skelLine(e.model, i)
				if va.Z > 0 and vb.Z > 0 then
					local dx, dy = vb.X - va.X, vb.Y - va.Y
					f.Position = UDim2.fromOffset(va.X, va.Y)
					f.Size = UDim2.fromOffset(math.sqrt(dx * dx + dy * dy), S.skeletonThickness)
					f.Rotation = math.deg(math.atan2(dy, dx))
					f.BackgroundColor3 = S.skeletonColor
					f.Visible = true
				else
					ok = false
				end
			end
		end
		local set = skelLines[e.model]
		if set then for i = (ok and #segs or 0) + 1, #set do set[i].Visible = false end end
	end
	for model, set in pairs(skelLines) do
		if not alive[model] then
			for _, f in ipairs(set) do f.Visible = false end
			if not model.Parent then
				for _, f in ipairs(set) do f:Destroy() end
				skelLines[model] = nil
			end
		end
	end
end))

-- ===========================================================================
-- FEATURE: 2D box ESP (customizable, team-colored)
-- ===========================================================================
local boxGui = Instance.new("ScreenGui")
boxGui.Name = "OP1_Boxes"; boxGui.ResetOnSpawn = false; boxGui.DisplayOrder = 995; boxGui.IgnoreGuiInset = true; boxGui.Parent = CG
local BOX_PARTS = { "head", "torso", "arm1", "arm2", "leg1", "leg2" }
local function projectBodyBox(model, cam)
	local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
	local found = false
	for _, name in ipairs(BOX_PARTS) do
		local p = model:FindFirstChild(name)
		if p and p:IsA("BasePart") then
			found = true
			for xi = -1, 1, 2 do
				for yi = -1, 1, 2 do
					for zi = -1, 1, 2 do
						local vp = cam:WorldToViewportPoint(p.CFrame * Vector3.new(p.Size.X * 0.5 * xi, p.Size.Y * 0.5 * yi, p.Size.Z * 0.5 * zi))
						if vp.Z <= 0 then return nil end
						minX = math.min(minX, vp.X); maxX = math.max(maxX, vp.X)
						minY = math.min(minY, vp.Y); maxY = math.max(maxY, vp.Y)
					end
				end
			end
		end
	end
	if not found then return nil end
	return minX, minY, maxX, maxY
end
local function projectBBox(model, cam)
	if not model then return nil end
	local cf, size = model:GetBoundingBox()
	if size.Magnitude < 0.01 then return nil end
	local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
	for xi = -1, 1, 2 do
		for yi = -1, 1, 2 do
			for zi = -1, 1, 2 do
				local vp = cam:WorldToViewportPoint(cf * Vector3.new(size.X * 0.5 * xi, size.Y * 0.5 * yi, size.Z * 0.5 * zi))
				if vp.Z <= 0 then return nil end
				minX = math.min(minX, vp.X); maxX = math.max(maxX, vp.X)
				minY = math.min(minY, vp.Y); maxY = math.max(maxY, vp.Y)
			end
		end
	end
	if minX == math.huge then return nil end
	return minX, minY, maxX, maxY
end
local boxItems = {}
local function boxItem(model)
	local it = boxItems[model]
	if it then return it end
	local f = Instance.new("Frame")
	f.BackgroundTransparency = 1; f.BorderSizePixel = 0; f.Visible = false; f.Parent = boxGui
	local s = Instance.new("UIStroke"); s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; s.LineJoinMode = Enum.LineJoinMode.Miter; s.Parent = f
	it = { frame = f, stroke = s }
	boxItems[model] = it
	return it
end
track(RunService.RenderStepped:Connect(function()
	if not S.boxEsp then
		for _, it in pairs(boxItems) do it.frame.Visible = false end
		return
	end
	local cam = WS.CurrentCamera
	if not cam then return end
	local alive = {}
	for _, e in ipairs(getEnemies({ noTeam = not S.teamCheck })) do
		local body = e.char or e.model
		if not body then continue end
		if S.teamCheck and (e.teamSame or isTeammate(e)) then continue end
		alive[body] = true
		local it = boxItem(body)
		local minX, minY, maxX, maxY = projectBBox(body, cam)
		if minX then
			local col = S.boxColor
			it.frame.Position = UDim2.fromOffset(minX, minY)
			it.frame.Size = UDim2.fromOffset(math.max(1, maxX - minX), math.max(1, maxY - minY))
			it.frame.BackgroundColor3 = col
			it.frame.BackgroundTransparency = S.boxFill and 0.7 or 1
			it.stroke.Color = col
			it.stroke.Thickness = S.boxThickness
			it.frame.Visible = true
		else
			it.frame.Visible = false
		end
	end
	for model, it in pairs(boxItems) do
		if not alive[model] then
			it.frame.Visible = false
			if not model.Parent then it.frame:Destroy(); boxItems[model] = nil end
		end
	end
end))

-- ===========================================================================
-- FEATURE: Device ESP (C4 / Claymore and other placed devices)
-- ===========================================================================
local deviceGui = Instance.new("ScreenGui")
deviceGui.Name = "OP1_Devices"; deviceGui.ResetOnSpawn = false; deviceGui.DisplayOrder = 995; deviceGui.IgnoreGuiInset = true; deviceGui.Parent = CG
local deviceParts = {}
local function deviceKind(name)
	local n = name:lower()
	if n:find("claymore") then return "CLAYMORE" end
	if n:find("remotec4") or n:find("c4") or n:find("breachcharge") or n:find("thermite") then return "C4" end
	if n:find("proximityalarm") then return "ALARM" end
	return nil
end
local function trackDevice(d)
	local k
	if d:IsA("BasePart") then k = deviceKind(d.Name)
	elseif d:IsA("Model") then k = deviceKind(d.Name) end
	if not k then return end
	if d:IsA("Model") then
		local p = d.PrimaryPart or d:FindFirstChildWhichIsA("BasePart")
		if p then deviceParts[p] = k end
	else
		deviceParts[d] = k
	end
end
for _, d in ipairs(WS:GetDescendants()) do trackDevice(d) end
track(WS.DescendantAdded:Connect(trackDevice))
track(WS.DescendantRemoving:Connect(function(d) deviceParts[d] = nil end))
local deviceLabels = {}
local function deviceLabel(part)
	local l = deviceLabels[part]
	if l then return l end
	l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1; l.Font = Enum.Font.GothamBold; l.TextSize = 12
	l.TextStrokeTransparency = 0; l.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	l.AnchorPoint = Vector2.new(0.5, 1); l.Visible = false; l.Parent = deviceGui
	deviceLabels[part] = l
	return l
end
track(RunService.RenderStepped:Connect(function()
	if not S.deviceEsp then
		for _, l in pairs(deviceLabels) do l.Visible = false end
		return
	end
	local cam = WS.CurrentCamera
	if not cam then return end
	for part, kind in pairs(deviceParts) do
		local l = deviceLabels[part]
		if part.Parent then
			if not l then l = deviceLabel(part) end
			local vp = cam:WorldToViewportPoint(part.Position + Vector3.new(0, 2, 0))
			if vp.Z > 0 then
				local dist = math.floor((part.Position - cam.CFrame.Position).Magnitude)
				l.Position = UDim2.fromOffset(vp.X, vp.Y)
				l.Text = string.format("%s  %d", kind, dist)
				l.TextColor3 = S.deviceColor
				l.Visible = true
			else
				l.Visible = false
			end
		else
			if l then l:Destroy(); deviceLabels[part] = nil end
			deviceParts[part] = nil
		end
	end
end))


-- ===========================================================================
-- FEATURE: Bullet Tracers (white, 1s lifespan)
-- ===========================================================================

local tracerFiring = false
local tracerLastShot = 0
local TRACER_FIRE_RATE = 0.1
local TRACER_DOWN_OFFSET = 0.15

local function getShotPosition()
	local viewmodels = WS:FindFirstChild("Viewmodels")
	local viewmodel = viewmodels and viewmodels:FindFirstChild("LocalViewmodel")
	if not viewmodel then return nil end

	local shoot = viewmodel:FindFirstChild("Shoot", true)
	if shoot and shoot:IsA("Attachment") then
		return shoot.WorldPosition - Vector3.new(0, TRACER_DOWN_OFFSET, 0)
	end
	return nil
end

local function createTracer(origin, target)
	if not S.bulletTracers then return end
	if not origin or not target then return end

	local a0 = Instance.new("Attachment")
	a0.WorldPosition = origin
	a0.Parent = workspace.Terrain

	local a1 = Instance.new("Attachment")
	a1.WorldPosition = target
	a1.Parent = workspace.Terrain

	local beam = Instance.new("Beam")
	beam.Attachment0 = a0
	beam.Attachment1 = a1
	beam.FaceCamera = true
	beam.Color = ColorSequence.new(S.tracerColor or Color3.new(1, 1, 1))
	beam.Width0 = S.tracerThickness or 0.13
	beam.Width1 = (S.tracerThickness or 0.13) * 0.3
	beam.LightEmission = 1
	beam.LightInfluence = 0
	beam.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.6, 0.25),
		NumberSequenceKeypoint.new(1, 1)
	})
	beam.Parent = workspace.Terrain

	task.delay(S.tracerLifetime or 1, function()
		pcall(function() beam:Destroy() end)
		pcall(function() a0:Destroy() end)
		pcall(function() a1:Destroy() end)
	end)
end

local function fireTracer()
	local camera = workspace.CurrentCamera
	if not camera then return end

	-- Start slightly below the real Shoot attachment
	local origin = getShotPosition()
	if not origin then return end

	local target

	-- 1. Prefer silent aim / ragebot target if active
	local aimAt = workspace:GetAttribute("__op1_saAimAt")
	local aimT = workspace:GetAttribute("__op1_saAimAtT")
	if typeof(aimAt) == "Vector3" and type(aimT) == "number" and (os.clock() - aimT) < 0.2 then
		target = aimAt
	else
		-- 2. Raycast from the CAMERA (true aim), not from the lowered origin
		local camPos = camera.CFrame.Position
		local direction = camera.CFrame.LookVector * 500

		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = {
			player.Character,
			workspace:FindFirstChild("Viewmodels")
		}

		local result = workspace:Raycast(camPos, direction, params)

		if result then
			target = result.Position
		else
			target = camPos + direction
		end
	end

	createTracer(origin, target)
end

-- Hold-to-fire detection
track(UIS.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		tracerFiring = true
	end
end))

track(UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		tracerFiring = false
	end
end))

track(RunService.RenderStepped:Connect(function()
	if not S.bulletTracers then return end

	-- Manual hold fire
	if tracerFiring then
		local now = os.clock()
		if now - tracerLastShot >= TRACER_FIRE_RATE then
			tracerLastShot = now
			fireTracer()
		end
		return
	end

	-- Also catch ragebot / auto-fire (they use mouse1press)
	local aimT = WS:GetAttribute("__op1_saAimAtT")
	if type(aimT) == "number" and (os.clock() - aimT) < 0.08 then
		local now = os.clock()
		if now - tracerLastShot >= TRACER_FIRE_RATE then
			tracerLastShot = now
			fireTracer()
		end
	end
end))

-- ===========================================================================
-- FEATURE: Drawing-based player ESP (fixed – uses real character models)
-- ===========================================================================
local drawItems = {}
cleanupDraw = function()
	for _, it in pairs(drawItems) do
		pcall(function() it.box:Remove(); it.hp:Remove(); it.name:Remove(); it.tracer:Remove(); it.gun:Remove() end)
	end
	drawItems = {}
end

local function drawItem(player)
	local it = drawItems[player]
	if it then return it end
	local function mk(t, props)
		local o = Drawing.new(t)
		for k, v in pairs(props) do o[k] = v end
		return o
	end
	it = {
		box    = mk("Square", {Thickness = 1, Filled = false, Color = Color3.new(1,1,1), Visible = false}),
		hp     = mk("Line",   {Thickness = 2, Visible = false}),
		name   = mk("Text",   {Size = 13, Center = true, Outline = true, Font = 2, Visible = false}),
		gun    = mk("Text",   {Size = 13, Center = true, Outline = true, Font = 2, Visible = false}),
		tracer = mk("Line",   {Thickness = 1, Visible = false}),
		LastPos = nil,
		StuckTime = 0
	}
	drawItems[player] = it
	return it
end

local function drawHide(it)
	it.box.Visible = false
	it.hp.Visible = false
	it.name.Visible = false
	it.gun.Visible = false
	it.tracer.Visible = false
end

local function getEquippedName(plr, char)
	for _, ch in ipairs({char, plr.Character}) do
		if ch then
			local cfg = ch:FindFirstChild("Character")
			if cfg then
				local eq = cfg:FindFirstChild("equipped")
				local item = eq and eq.Value
				if item and item.Name ~= "" then return item.Name end
				local hold = cfg:FindFirstChild("holding")
				local hv = hold and hold.Value
				if hv and hv.Name ~= "" then return hv.Name end
			end
		end
	end
	return ""
end

local findRealChar = findCharacter

local function getSimpleBox(character, cam)
	local cf, size = character:GetBoundingBox()
	local top    = cf.Position + Vector3.new(0, size.Y/2, 0)
	local bottom = cf.Position - Vector3.new(0, size.Y/2, 0)
	local topPos = cam:WorldToViewportPoint(top)
	local bottomPos = cam:WorldToViewportPoint(bottom)
	-- Only reject when the box is behind the camera. Requiring InViewport (the old
	-- vis1/vis2 check) made the whole box vanish whenever the head or feet were even
	-- 1px outside the screen, which is why boxes flickered off at the edges.
	if topPos.Z <= 0 or bottomPos.Z <= 0 then return nil end
	local height = math.abs(topPos.Y - bottomPos.Y)
	local width  = height / 2
	return Vector2.new(topPos.X - width/2, topPos.Y), width, height
end



-- Friendly-fire guard for clicks: if the FIRST thing a shot from the camera toward the aim
-- point would hit is one of our own bodies, the game registers that hit on the teammate
-- (that is the "teammates still get shot" case -- the target itself is a valid enemy).
local teammatePathParams = RaycastParams.new()
teammatePathParams.FilterType = Enum.RaycastFilterType.Exclude
local function teammateInPath(camPos, aimPos)
	local lpT = LP:GetAttribute("Team") or (LP.Team and LP.Team.Name)
	if not lpT or lpT == "Spectate" then return false end
	local d = aimPos - camPos
	if d.Magnitude < 0.5 then return false end
	local members = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP then
			local t = p:GetAttribute("Team") or (p.Team and p.Team.Name)
			if t == lpT and t ~= "Spectate" then
				local ch = p.Character
				if ch and ch:FindFirstChildOfClass("Humanoid") then members[#members + 1] = ch end
			end
		end
	end
	if #members == 0 then return false end
	teammatePathParams.FilterDescendantsInstances = getIgnore()
	local hit = WS:Raycast(camPos, d, teammatePathParams)
	if not hit then return false end
	for _, m in ipairs(members) do
		if hit.Instance == m or hit.Instance:IsDescendantOf(m) then return true end
	end
	return false
end

track(RunService.RenderStepped:Connect(function(dt)
	if not S.drawEsp then
		for _, it in pairs(drawItems) do drawHide(it) end
		return
	end

	local cam = WS.CurrentCamera
	if not cam then return end

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LP then
			local it = drawItem(plr)

			if S.teamCheck and isTeammate(plr) then
				drawHide(it)
				it.LastPos = nil
				it.StuckTime = 0
			else
				local character, humanoid, root = findCharacter(plr)

				if not character or not humanoid or humanoid.Health <= 0 then
					drawHide(it)
					it.LastPos = nil
					it.StuckTime = 0
				else
					local t = plr.Team and plr.Team.Name or plr:GetAttribute("Team")
					if t == "Spectate" then
						drawHide(it)
						it.LastPos = nil
						it.StuckTime = 0
					else
						local pos, width, height = getSimpleBox(character, cam)
						if not pos then
							drawHide(it)
							it.LastPos = nil
							it.StuckTime = 0
						else
							if it.LastPos and (it.LastPos - pos).Magnitude < 1 then
								it.StuckTime = it.StuckTime + dt
								if it.StuckTime >= 1.5 then
									drawHide(it)
									it.LastPos = nil
									it.StuckTime = 0
									continue
								end
							else
								it.StuckTime = 0
							end

							it.LastPos = pos
							local col = S.espColor

							it.box.Size = Vector2.new(width, height)
							it.box.Position = pos
							it.box.Color = col
							it.box.Visible = S.drawBox

							local frac = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
							it.hp.From = Vector2.new(pos.X - 5, pos.Y + height)
							it.hp.To   = Vector2.new(pos.X - 5, pos.Y + height - height * frac)
							it.hp.Color = Color3.fromRGB(255 - 255 * frac, 255 * frac, 0)
							it.hp.Visible = S.drawHealth

							local dist = math.floor((cam.CFrame.Position - root.Position).Magnitude)
							it.name.Text = plr.Name .. "  [" .. dist .. "m]"
							it.name.Position = Vector2.new(pos.X + width/2, pos.Y - 15)
							it.name.Color = col
							it.name.Visible = S.drawName

							if S.gunEsp then
								local gunName = getEquippedName(plr, character)
								if gunName ~= "" then
									it.gun.Text = gunName
									it.gun.Position = Vector2.new(pos.X + width/2, pos.Y + height + 4)
									it.gun.Color = S.gunEspColor
									it.gun.Visible = true
								else
									it.gun.Visible = false
								end
							else
								it.gun.Visible = false
							end

							it.tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
							it.tracer.To   = Vector2.new(pos.X + width/2, pos.Y + height)
							it.tracer.Color = col
							it.tracer.Visible = S.drawTracer
						end
					end
				end
			end
		end
	end

	for plr, it in pairs(drawItems) do
		if not plr.Parent then
			pcall(function()
				it.box:Remove(); it.hp:Remove(); it.name:Remove(); it.tracer:Remove(); it.gun:Remove()
			end)
			drawItems[plr] = nil
		end
	end
end))
-- ===========================================================================
-- FEATURE: Hitmarker (hooks game's hitmarker system)
-- ===========================================================================
local hmGui = Instance.new("ScreenGui")
hmGui.Name = "OP1_Hitmarker"; hmGui.ResetOnSpawn = false; hmGui.DisplayOrder = 999; hmGui.IgnoreGuiInset = true; hmGui.Parent = CG
local hmImage = Instance.new("ImageLabel")
hmImage.AnchorPoint = Vector2.new(0.5, 0.5); hmImage.BackgroundTransparency = 1; hmImage.Visible = false; hmImage.Parent = hmGui
local hmAsset = ""
pcall(function() hmAsset = getcustomasset("Hitmarker.png") end)
if hmAsset ~= "" then hmImage.Image = hmAsset end
local hmLines = {}
for i = 1, 4 do
	local f = Instance.new("Frame")
	f.BackgroundColor3 = Color3.fromRGB(255, 255, 255); f.BorderSizePixel = 0; f.AnchorPoint = Vector2.new(0, 0.5); f.Visible = false; f.Parent = hmGui
	hmLines[i] = f
end
local function gameHitMarker()
	local pg = LP:FindFirstChild("PlayerGui")
	local g = pg and pg:FindFirstChild("Game")
	local c1 = g and g:FindFirstChild("Center")
	local c2 = c1 and c1:FindFirstChild("Center")
	return c2 and c2:FindFirstChild("HitMarker")
end
local hmTimer, hmWasVisible = 0, false
local hmShotOrigin = nil
local hmShotTarget = nil
local hmHitSuccessful = false
track(RunService.RenderStepped:Connect(function(dt)
	local folder = gameHitMarker()
	local vis = false
	if folder then
		for _, c in ipairs(folder:GetChildren()) do
			if c:IsA("GuiObject") and c.Visible then vis = true break end
		end
	end
	if vis and not hmWasVisible then hmTimer = S.hitmarkerDuration end
	hmWasVisible = vis
	if hmTimer > 0 then hmTimer = math.max(0, hmTimer - dt) end
	local a = S.hitmarkerDuration > 0 and (hmTimer / S.hitmarkerDuration) or 0
	local show = S.hitmarker and a > 0
	local cam = WS.CurrentCamera
	local center = cam and (cam.ViewportSize * 0.5) or Vector2.new(960, 540)
	-- Log ragebot shots for targeting analysis
	if S.rbEnabled and rbShotLog then
		if rbShotLog.lastShot and os.clock() - rbShotLog.lastShot < 1 then
			local hitStatus = rbShotLog.hit and "HIT" or "MISS"
			Library:Notification(string.format("RB SHOT: %s @ %s", hitStatus, rbShotLog.targetName or "unknown"), 2, nil)
		end
		rbShotLog = {lastShot = 0, hit = false, targetName = ""}
	end
	-- Original hitmarker code
	if hmAsset ~= "" then
		for _, f in ipairs(hmLines) do f.Visible = false end
		if show then
			hmImage.Size = UDim2.fromOffset(S.hitmarkerSize, S.hitmarkerSize)
			hmImage.Position = UDim2.fromOffset(center.X, center.Y)
			hmImage.ImageColor3 = S.hitmarkerColor
			hmImage.ImageTransparency = 1 - a
		end
		hmImage.Visible = show
	else
		hmImage.Visible = false
		local r = S.hitmarkerSize * 0.5
		local inner = r * 0.35
		for i = 1, 4 do
			local f = hmLines[i]
			if show then
				local sx = (i == 1 or i == 2) and -1 or 1
				local sy = (i == 1 or i == 4) and -1 or 1
				local ax, ay = center.X + sx * inner, center.Y + sy * inner
				local bx, by = center.X + sx * r, center.Y + sy * r
				local dx, dy = bx - ax, by - ay
				f.Position = UDim2.fromOffset(ax, ay)
				f.Size = UDim2.fromOffset(math.sqrt(dx * dx + dy * dy), 2)
				f.Rotation = math.deg(math.atan2(dy, dx))
				f.BackgroundColor3 = S.hitmarkerColor
				f.BackgroundTransparency = 1 - a
				f.Visible = true
			else
				f.Visible = false
			end
		end
	end
end))

-- Auto-log ragebot shots
track(RunService.RenderStepped:Connect(function()
	if S.rbEnabled and S.rbLogShots then
		-- Check if we had a recent shot
		local char = LP.Character
		local weapon = char and char:FindFirstChild("equipped") and char.equipped.Value
		local gun = weapon and weapon:FindFirstChild("Gun")
		if gun then
			local muzzle = gun:FindFirstChild("Muzzle") or gun:FindFirstChild("muzzle") or gun:FindFirstChild("Barrel") or gun:FindFirstChild("barrel")
			if muzzle then
				rbShotLog = {
					lastShot = os.clock(),
					hit = false,
					targetName = "rb_target"
				}
			end
		end
	end
end))

track(RunService.RenderStepped:Connect(function()
	-- panel
	if S.enemyPanel then
		panelGui.Enabled = true
		local enemies = getEnemies(); local ignore = getIgnore(); local shown = 0
		for _, e in ipairs(enemies) do
			shown = shown + 1
			local r = row(shown)
			local status = rayStatus(e.head, e.model, ignore)
			local dist = math.floor((e.head.Position - WS.CurrentCamera.CFrame.Position).Magnitude)
			r.name.Text = e.name
			if status == "vis" then
				r.name.TextColor3 = Color3.fromRGB(74, 222, 128); r.badge.Text = "VIS " .. dist; r.badge.TextColor3 = Color3.fromRGB(74, 222, 128)
			elseif status == "wb" then
				r.name.TextColor3 = Color3.fromRGB(74, 222, 128); r.badge.Text = "WB " .. dist; r.badge.TextColor3 = Color3.fromRGB(74, 222, 128)
			else
				r.name.TextColor3 = Color3.fromRGB(248, 113, 113); r.badge.Text = "BLOCKED " .. dist; r.badge.TextColor3 = Color3.fromRGB(248, 113, 113)
			end
			r.frame.Visible = true
		end
		for i = shown + 1, #rows do rows[i].frame.Visible = false end
		pTitle.Text = "ENEMIES  ·  " .. #enemies
		panel.Size = UDim2.fromOffset(196, 38 + math.max(1, shown) * 21)
	else
		panelGui.Enabled = false
	end

	-- fov circle (origin = crosshair = viewport center)
	local cam = WS.CurrentCamera
	local vp = cam and cam.ViewportSize or Vector2.new(1920, 1080)
	local mouse = Vector2.new(vp.X * 0.5, vp.Y * 0.5)
	if S.fovCheck and S.silentAim then
		fovCircle.Visible = true
		local sc = (cam and fovScaleFor(cam)) or 1
		fovCircle.Size = UDim2.fromOffset(S.fov * 2 * sc, S.fov * 2 * sc)
		fovCircle.Position = UDim2.fromOffset(mouse.X, mouse.Y)
	else
		fovCircle.Visible = false
	end

	-- Ragebot logic
	if S.rbEnabled then
		-- auto-wallbang latches itself on above; clear it again the moment the toggle drops,
		-- so the actor hook cannot keep penetrating walls behind ragebot's back
		WS:SetAttribute("__op1_saWallbang", S.saWallbang or S.rbAutoWallbang or S.rbAutoWB)
		-- ragebot runs ungated by the Aim section's FOV circle (that gate belongs to silent aim)
		local targets = getTargets({ noFov = true })
		-- take the first target that is NOT on our team AND passes the wall check, so a hidden
		-- nearest target never blocks a visible one sitting behind it
		local target
		for _, t in ipairs(targets) do
			if not isTeammate(t.e) and (not S.rbVisualCheck or t.status == "vis") then
				target = t
				break
			end
		end
		if target and target.e and target.e.head then
			local aimPart = target.aim or target.e.head
			-- Auto shoot
			if S.rbAutoShoot and not (Window and Window.IsOpen)
				and not teammateInPath(cam.CFrame.Position, aimPart.Position) then
				WS:SetAttribute("__op1_saAimAt", aimPart.Position)
				WS:SetAttribute("__op1_saAimAtT", os.clock())
				pcall(function() mouse1press() end)
				task.delay(0.01, function() pcall(function() mouse1release() end) end)
			end
		end
	end
end))

-- ===========================================================================
-- FEATURE: Silent aim (actor hook) — reads settings from workspace attributes
-- ===========================================================================
WS:SetAttribute("__op1_saOn", S.silentAim)
WS:SetAttribute("__op1_saOverwrite", false)
WS:SetAttribute("__op1_noSpread", S.noSpread == true)
local function installSilentAimHook()
	if silentAimInstalled then return end
	local actors = getactors and getactors()
	if not (actors and #actors > 0) then return end
	run_on_actor(actors[1], [==[
type UMod = { [string]: (...any) -> any }
local W = workspace
local G = require(game.ReplicatedStorage.Modules.Items.Item.Gun)
local U = game:GetService("UserInputService")
local C = W.CurrentCamera
local D = debug
local LP = game:GetService("Players").LocalPlayer
local function penetrable(p)
    local par = p.Parent
    local hard = p:GetAttribute("Hard") or (par and par:GetAttribute("Hard"))
    local soft = p:GetAttribute("Soft") or (par and par:GetAttribute("Soft"))
    local solid = (not soft) and p.CanCollide == true and p.Transparency < 1
    if hard or solid then
        local s = { p.Size.X, p.Size.Y, p.Size.Z }; table.sort(s)
        if s[2] < 1.45 and ((not p:HasTag("WallPart") and not hard) or s[2] <= 0.5) then return true end
        return false
    end
    return true
end
local function rayStatus(head, model, ignore, fromPos)
    if not C then return nil end
    local last = fromPos or C.CFrame.Position
    local params = RaycastParams.new(); params.FilterType = Enum.RaycastFilterType.Exclude; params.FilterDescendantsInstances = ignore
    local layers = 0
    for _ = 1, 20 do
        local dir = head.Position - last
        if dir.Magnitude < 0.2 then return layers == 0 and "vis" or "wb" end
        local r = W:Raycast(last, dir, params)
        if not r then return layers == 0 and "vis" or "wb" end
        local inst = r.Instance
        if inst == head or inst.Parent == model then return layers == 0 and "vis" or "wb" end
        params:AddToFilter(inst)
        if not penetrable(inst) then return nil end
        layers = layers + 1; last = r.Position + dir.Unit * 0.05
    end
    return nil
end
local function targetable(status, wallbang, visible)
    if wallbang then return status ~= nil end
    if visible then return status == "vis" end
    return true
end
local PlayersSvc = game:GetService("Players")
local function playerRef(plr)
    if not plr.Character then return nil end
    return plr.Character:FindFirstChild("HumanoidRootPart")
        or plr.Character:FindFirstChild("Torso")
        or plr.Character:FindFirstChild("UpperTorso")
        or plr.Character:FindFirstChild("head")
end
local function buildVMMap()
    local map = {}
    local vmr = W:FindFirstChild("Viewmodels")
    if not vmr then return map end
    local vms = {}
    for _, c in ipairs(vmr:GetChildren()) do
        if c.Name ~= "LocalViewmodel" and c:IsA("Model") then
            local h = c:FindFirstChild("head") or c:FindFirstChild("torso")
            if h then vms[#vms + 1] = { vm = c, pos = h.Position } end
        end
    end
    local plrs = {}
    for _, p in ipairs(PlayersSvc:GetPlayers()) do
        if p ~= LP then
            local ref = playerRef(p)
            if ref then plrs[#plrs + 1] = { plr = p, pos = ref.Position } end
        end
    end
    local cand = {}
    for i, v in ipairs(vms) do
        for j, q in ipairs(plrs) do
            local d = (v.pos - q.pos).Magnitude
            if d < 12 then cand[#cand + 1] = { i = i, j = j, d = d } end
        end
    end
    table.sort(cand, function(a, b) return a.d < b.d end)
    local uvm, upl = {}, {}
    for _, c in ipairs(cand) do
        if not uvm[c.i] and not upl[c.j] then
            uvm[c.i] = true; upl[c.j] = true
            local plr = plrs[c.j].plr
            local hum = plr.Character and (plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character:FindFirstChild("Humanoid"))
            map[vms[c.i].vm] = { team = plr:GetAttribute("Team"), alive = (hum == nil or hum.Health > 0) }
        end
    end
    return map
end
if __op1OrigUtil == nil then __op1OrigUtil = D.getupvalue(G.send_shoot, 1) end
local cur = D.getupvalue(G.send_shoot, 1)
local R: UMod = cur
if type(cur) == "table" and getmetatable(cur) ~= nil then
    local vp = cur.validate_position
    for i = 1, 16 do
        local a, b = D.getupvalue(vp, i)
        if a == nil and b == nil then break end
        if type(a) == "table" and type(a.validate_position) == "function" and getmetatable(a) == nil then R = a break end
        if type(b) == "table" and type(b.validate_position) == "function" and getmetatable(b) == nil then R = b break end
    end
end
D.setupvalue(G.send_shoot, 1, setmetatable({}, {
    __index = function(_, k: string) return k == "validate_position" and function(o, t, r)
        local fromShoot = D.traceback():find("send_shoot") ~= nil
        -- No Spread: zero the spread state right before send_shoot reads it (state.value, no hooks fired)
        if fromShoot then
            if __op1SpreadSaved == nil then __op1SpreadSaved = {} end
            local g = D.getstack(2, 1)
            if type(g) == "table" and type(g.states) == "table" and type(g.states.spread) == "table" then
                local sp = g.states.spread
                if W:GetAttribute("__op1_noSpread") then
                    if __op1SpreadSaved[sp] == nil then __op1SpreadSaved[sp] = sp.value end
                    sp.value = 0
                    W:SetAttribute("__op1_spreadOrig", __op1SpreadSaved[sp]) -- probe: nil means the state table was never found
                elseif __op1SpreadSaved[sp] ~= nil then
                    sp.value = __op1SpreadSaved[sp]
                    __op1SpreadSaved[sp] = nil
                end
            end
        end
        if not W:GetAttribute("__op1_saOn") then return R.validate_position(o, t, r) end
        if not fromShoot then return R.validate_position(o, t, r) end
        local overwrite = W:GetAttribute("__op1_saOverwrite")
        local wallbang = W:GetAttribute("__op1_saWallbang")
        local visible = W:GetAttribute("__op1_saVisible")
        local fovCheck = W:GetAttribute("__op1_saFOVCheck")
        local fov = W:GetAttribute("__op1_saFOV") or 200
        -- keep the FOV allowance angular across scope zoom (camera FOV shrinks when zoomed,
        -- which would otherwise push an off-axis target outside a fixed-pixel circle)
        local fovScale = 1
        do
            local base = C and C:GetAttribute("OriginalFOV")
            if base and base > 0 and C and C.FieldOfView and C.FieldOfView > 0 then
                local t1 = math.tan(math.rad(base) * 0.5)
                local t2 = math.tan(math.rad(C.FieldOfView) * 0.5)
                if t1 > 0 and t2 > 0 then fovScale = t1 / t2 end
            end
        end
        -- Target Part: which body part the shot is redirected onto
        local aimPartNames = {
            Head = { "head", "Head" },
            Torso = { "torso", "Torso", "UpperTorso" },
            LowerTorso = { "lower_torso", "LowerTorso" },
            HumanoidRootPart = { "HumanoidRootPart" },
        }
        local function aimPartOf(ch, fallback)
            local want = W:GetAttribute("__op1_rbTargetPart")
            if want and want ~= "Auto" and ch then
                local names = aimPartNames[want]
                if names then
                    for _, n in ipairs(names) do
                        local p = ch:FindFirstChild(n)
                        if p and p:IsA("BasePart") then return p end
                    end
                end
            end
            return fallback
        end
        local maxAngle = W:GetAttribute("__op1_saMaxAngle") or 45
        local teamCheck = W:GetAttribute("__op1_saTeam")
        local vm = W:FindFirstChild("Viewmodels")
        local ignore = {}
        if LP.Character then ignore[#ignore + 1] = LP.Character end
        if vm then local lvm = vm:FindFirstChild("LocalViewmodel"); if lvm then ignore[#ignore + 1] = lvm end end
        local vp = C.ViewportSize
        local mouse = Vector2.new(vp.X * 0.5, vp.Y * 0.5)
        local priority = W:GetAttribute("__op1_saPriority")
        local aimAt = W:GetAttribute("__op1_saAimAt")
        local aimT = W:GetAttribute("__op1_saAimAtT")
        local forced = typeof(aimAt) == "Vector3" and type(aimT) == "number" and (os.clock() - aimT) < 0.2
        local best, bestD = nil, math.huge
        local candCount = 0
        local lpTeam = LP:GetAttribute("Team")
        local function consider(head)
            if not (head and head:IsA("BasePart")) then return end
            local status = rayStatus(head, head.Parent, ignore)
            local okTarget
            if overwrite then okTarget = status ~= nil else okTarget = targetable(status, wallbang, visible) end
            if not okTarget then return end
            if not C then return end
            local sp = C:WorldToViewportPoint(head.Position)
            if sp.Z <= 0 then return end
            local dx, dy = sp.X - mouse.X, sp.Y - mouse.Y
            local d = math.sqrt(dx * dx + dy * dy)
            local okFov = overwrite or (not fovCheck) or d <= fov * fovScale
            local okAngle = true
            if okFov and maxAngle < 180 then
                local dir = head.Position - C.CFrame.Position
                if dir.Magnitude > 0.001 then
                    okAngle = math.deg(math.acos(math.clamp(dir.Unit:Dot(C.CFrame.LookVector), -1, 1))) <= maxAngle
                end
            end
            if okFov and okAngle then
                candCount = candCount + 1
                local metric = priority == "Nearest" and (head.Position - C.CFrame.Position).Magnitude or d
                if metric < bestD then bestD, best = metric, head.Position end
            end
        end
        -- real player characters (the visible enemies) first
        for _, p in ipairs(PlayersSvc:GetPlayers()) do
            if p ~= LP then
                local ch = p.Character
                local hum = ch and (ch:FindFirstChildOfClass("Humanoid") or ch:FindFirstChild("Humanoid"))
                if ch and (hum == nil or hum.Health > 0) then
                    local t = p:GetAttribute("Team")
                    if t ~= "Spectate" and not (teamCheck and t ~= nil and lpTeam ~= nil and t == lpTeam) then
                        consider(aimPartOf(ch, ch:FindFirstChild("head") or ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")))
                    end
                end
            end
        end
        -- their viewmodels too (fallback / when the character has no head)
        if vm then
            local teamMap = buildVMMap()
            for _, x in ipairs(vm:GetChildren()) do
                if x.Name ~= "LocalViewmodel" and x:IsA("Model") then
                    local info = teamMap[x]
                    if info and info.alive and info.team ~= "Spectate" and not (teamCheck and info.team ~= nil and lpTeam ~= nil and info.team == lpTeam) then
                        consider(aimPartOf(x, x:FindFirstChild("head") or x:FindFirstChild("Head")))
                    end
                end
            end
        end
        -- autofire publishes the target it clicked on: always redirect onto it -- unless that
        -- point currently holds one of OUR teammates (the published point can be up to 0.2s old
        -- and the publisher may be team-blind; friendlies walk into stale aim points constantly)
        if forced then
            local forcedOk = true
            if lpTeam ~= nil and lpTeam ~= "Spectate" then
                for _, pp in ipairs(PlayersSvc:GetPlayers()) do
                    if pp ~= LP then
                        local pt = pp:GetAttribute("Team")
                        if pt ~= nil and pt == lpTeam and pt ~= "Spectate" then
                            local pc = pp.Character
                            local pr = pc and pc:FindFirstChild("HumanoidRootPart")
                            if pr and (pr.Position - aimAt).Magnitude < 3 then
                                forcedOk = false
                                break
                            end
                        end
                    end
                end
            end
            if forcedOk then
                best = aimAt
                if candCount == 0 then candCount = 1 end
            end
        end
W:SetAttribute("__op1_saShots", (W:GetAttribute("__op1_saShots") or 0) + 1)
		W:SetAttribute("__op1_saLastCand", candCount)
		W:SetAttribute("__op1_saLastHit", best ~= nil)
        if best then
            local cf: any = D.getstack(2, 3)
            local manipO = W:GetAttribute("__op1_manipOrigin")
            local manipT = W:GetAttribute("__op1_manipT")
            local useManip = typeof(manipO) == "Vector3"
                and type(manipT) == "number"
                and (os.clock() - manipT) < 0.15

            if useManip then
                -- force look from the PROBE origin to the target
                if typeof(cf) == "CFrame" then
                    D.setstack(2, 5, CFrame.lookAt(manipO, best))
                end
                -- return the probe as the validated origin (do NOT clamp back to muzzle)
                return manipO
            end

            if typeof(cf) == "CFrame" then
                D.setstack(2, 5, CFrame.lookAt(cf.Position, best))
            end
        end
        return R.validate_position(o, t, r)
    end or R[k] end
}))
]==])
	silentAimInstalled = true
end
local function uninstallSilentAimHook()
	if not silentAimInstalled then return end
	local actors = getactors and getactors()
	if not (actors and #actors > 0) then return end
	run_on_actor(actors[1], [==[
		local ok1, G = pcall(function() return require(game.ReplicatedStorage.Modules.Items.Item.Gun) end)
		if ok1 and type(G) == "table" and type(G.send_shoot) == "function" and __op1OrigUtil ~= nil then
			debug.setupvalue(G.send_shoot, 1, __op1OrigUtil)
		end
		if not workspace:GetAttribute("__op1_noSpread") and type(__op1SpreadSaved) == "table" then
			for sp, v in pairs(__op1SpreadSaved) do
				if type(sp) == "table" then pcall(function() sp.value = v end) end
			end
			__op1SpreadSaved = nil
		end
	]==])
	silentAimInstalled = false
end
silentAimUninstall = uninstallSilentAimHook
-- NOTE: do NOT touch the actor at load. The hook is installed only when the user enables Silent Aim,
-- and restored to the exact original upvalue on disable/unload. (Never guess via require(Util).)

-- if the actor wasn't ready when a toggle fired, keep retrying until the hook lands
local lastHookRetry = 0
track(RunService.RenderStepped:Connect(function()
	if silentAimInstalled or not (S.silentAim or S.noSpread) then return end
	local now = os.clock()
	if now - lastHookRetry < 1 then return end
	lastHookRetry = now
	pcall(installSilentAimHook)
end))

-- ===========================================================================
-- FEATURE: Auto fire (fires while a targetable enemy is near the mouse)
-- ===========================================================================
local Window
local lastAuto = 0
track(RunService.RenderStepped:Connect(function()
	if not S.autoFire then return end
	if Window and Window.IsOpen then return end -- menu open: the synthetic click would hit the GUI and flip the toggle off
	if not S.silentAim then return end -- autofire never fires a raw shot; it always shoots through silent aim
	if not silentAimInstalled then return end -- shared retry above keeps trying to install it
	local targets = getTargets()
	if #targets == 0 then return end
	local now = os.clock()
	if now - lastAuto < 0.05 then return end
	local aimPart = targets[1].aim or (targets[1].e and targets[1].e.head)
	local cam = WS.CurrentCamera
	-- friendly-fire guard: if a teammate's body is the first thing this shot would hit,
	-- skip the click entirely (the raw bullet would register on them, not the target)
	if aimPart and cam and teammateInPath(cam.CFrame.Position, aimPart.Position) then return end
	lastAuto = now
	if aimPart then -- hand the exact target to the hook so the shot is always redirected onto it
		WS:SetAttribute("__op1_saAimAt", aimPart.Position)
		WS:SetAttribute("__op1_saAimAtT", now)
	end
	pcall(function() mouse1press() end)
	task.delay(0.015, function() pcall(function() mouse1release() end) end) end))
-- ===========================================================================
-- FEATURE: Fly (AlignPosition + PlatformStand)
-- ===========================================================================
local flyAP, flyBV, flyActive = nil, nil, false
local flyNoclipActive = false

local function flyGetParts()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    return char, hrp, hum
end

local function flyStart()
    local char, hrp, hum = flyGetParts()
    if not hrp or not hum then return end

    -- kill any residual velocity so we don't drift
    pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)

    flyAP = Instance.new("AlignPosition")
    flyAP.Name = "OP1_FlyAP"
    flyAP.Attachment0 = hrp.RootAttachment
    flyAP.Mode = Enum.PositionAlignmentMode.OneAttachment
    flyAP.MaxForce = 1e12
    flyAP.Responsiveness = 100
    flyAP.RigidityEnabled = false
    flyAP.Position = hrp.Position
    flyAP.Parent = hrp

    -- Humanoid won't try to walk or fall
    hum.PlatformStand = true

    flyActive = true
end

local function flyStop()
    if flyAP then pcall(function() flyAP:Destroy() end); flyAP = nil end
    local char, hrp, hum = flyGetParts()
    if hum then
        pcall(function() hum.PlatformStand = false end)
    end
    if flyNoclipActive then
        -- let noclip own restoration; if noclip is off too, restore collision
        if not S.noclipEnabled and char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
            flyNoclipActive = false
        end
    end
    flyActive = false
end

-- Fly movement: RenderStepped, runs BEFORE physics
track(RunService.RenderStepped:Connect(function(dt)
    if not S.flyEnabled then
        if flyActive then flyStop() end
        return
    end
    if not flyActive then flyStart() end
    if not flyAP or not flyAP.Parent then return end

    local char, hrp, hum = flyGetParts()
    if not hrp then flyStop() return end
    if flyAP.Parent ~= hrp then
        flyStop(); flyStart(); return
    end

    -- Keep Humanoid pinned so it doesn't fight us
    if hum and not hum.PlatformStand then
        hum.PlatformStand = true
    end

    local cam = WS.CurrentCamera
    if not cam then return end

    local look = cam.CFrame.LookVector
    local flatForward = Vector3.new(look.X, 0, look.Z)
    if flatForward.Magnitude < 0.01 then
        local ch = LP.Character
        local hrp2 = ch and ch:FindFirstChild("HumanoidRootPart")
        if hrp2 then
            local f = hrp2.CFrame.LookVector
            flatForward = Vector3.new(f.X, 0, f.Z)
        else
            flatForward = Vector3.new(0, 0, 1)
        end
    end
    flatForward = flatForward.Unit
    local flatRight = flatForward:Cross(Vector3.new(0, 1, 0)).Unit

    local move = Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then move += flatForward end
    if UIS:IsKeyDown(Enum.KeyCode.S) then move -= flatForward end
    if UIS:IsKeyDown(Enum.KeyCode.A) then move -= flatRight end
    if UIS:IsKeyDown(Enum.KeyCode.D) then move += flatRight end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end

    if move.Magnitude > 0.01 then
        flyAP.Position = flyAP.Position + move.Unit * S.flySpeed * dt
    end
end))

-- ===========================================================================
-- FEATURE: Force Grapple Fly (drives the game's own rappel state machine)
-- ===========================================================================
local fgAnchorPos = nil   -- our desired anchor in world space
local fgLastHook = nil
local fgInstalled = false

local function fgGetStateObjs()
    local items = LP:FindFirstChild("Items")
    local gh = items and items:FindFirstChild("GrapplingHook")
    local cfg = gh and gh:FindFirstChild("GrapplingHook")
    if not cfg then return nil end
    return {
        cfg = cfg,
        rappeling = cfg:FindFirstChild("rappeling"),
        hook = cfg:FindFirstChild("hook"),
    }
end

local function fgGetCharStates()
    -- the Character module's state objects (climbing, vault, falling)
    local char = LP.Character
    local charFolder = char and char:FindFirstChild("Character")
    if not charFolder then return nil end
    return {
        climbing = charFolder:FindFirstChild("climbing"),
        vault = charFolder:FindFirstChild("vault"),
        falling = charFolder:FindFirstChild("falling"),
    }
end

local function fgIsValidHook(cf)
    if not cf then return false end
    -- CFrame.new() has identity rotation and zero position; the game uses this as "stowed"
    if cf.Position.Magnitude < 0.001 then return false end
    return true
end

local function fgStart()
    local s = fgGetStateObjs()
    if not s or not s.rappeling or not s.hook then
        return false, "no GrapplingHook state objects"
    end

    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false, "no HRP" end

    -- if no hook exists yet, synthesize one directly in front of the camera
    local cam = WS.CurrentCamera
    if not cam then return false, "no camera" end
    local look = cam.CFrame.LookVector
    fgAnchorPos = hrp.Position + look.Unit * 20   -- 20 studs ahead

    -- snap the anchor to 90-degree yaw like the game does
    local function snap(cf)
        local yaw = math.atan2(-cf.LookVector.X, -cf.LookVector.Z)
        return CFrame.new(cf.Position) * CFrame.Angles(0, math.round(yaw / (math.pi/2)) * (math.pi/2), 0)
    end

    s.hook.Value = snap(CFrame.new(fgAnchorPos, fgAnchorPos - look.Unit))
    fgLastHook = s.hook.Value

    -- force the state flag; the client's setter fires the remote
    s.rappeling.Value = true

    -- belt and braces: force the character's climbing state to 2
    local cs = fgGetCharStates()
    if cs and cs.climbing then
        pcall(function() cs.climbing.Value = 2 end)
    end

    fgInstalled = true
    return true
end

local function fgStop()
    if not fgInstalled then return end
    local s = fgGetStateObjs()
    if s and s.rappeling then pcall(function() s.rappeling.Value = false end) end
    if s and s.hook then pcall(function() s.hook.Value = CFrame.new() end) end
    local cs = fgGetCharStates()
    if cs and cs.climbing then pcall(function() cs.climbing.Value = 0 end) end

    -- clean up any leftover AlignPosition the game parented
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        for _, c in ipairs(hrp:GetChildren()) do
            if c:IsA("AlignPosition") or c:IsA("AlignOrientation") then
                pcall(function() c:Destroy() end)
            end
        end
    end

    fgAnchorPos = nil
    fgLastHook = nil
    fgInstalled = false
end
getgenv().__op1_fgStop = fgStop

track(RunService.RenderStepped:Connect(function(dt)
    if not S.flyEnabled then
        if fgInstalled then fgStop() end
        return
    end

    if not fgInstalled then
        local ok, err = fgStart()
        if not ok then
            -- fail silently; user can check __op1_fgErr
            getgenv().__op1_fgErr = err
            return
        end
    end

    local s = fgGetStateObjs()
    if not s or not s.hook or not s.rappeling then fgStop() return end

    -- make sure the state didn't get cleared behind our back
    if not s.rappeling.Value then
        pcall(function() s.rappeling.Value = true end)
    end

    -- recompute the desired anchor from current camera + input
    local cam = WS.CurrentCamera
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not cam or not hrp then fgStop() return end

    local look = cam.CFrame.LookVector
    local flatForward = Vector3.new(look.X, 0, look.Z)
    if flatForward.Magnitude < 0.01 then flatForward = Vector3.new(0, 0, 1) end
    flatForward = flatForward.Unit
    local flatRight = flatForward:Cross(Vector3.new(0, 1, 0)).Unit

    local move = Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then move += flatForward end
    if UIS:IsKeyDown(Enum.KeyCode.S) then move -= flatForward end
    if UIS:IsKeyDown(Enum.KeyCode.A) then move -= flatRight end
    if UIS:IsKeyDown(Enum.KeyCode.D) then move += flatRight end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end

    -- push the anchor forward
    if fgAnchorPos then
        if move.Magnitude > 0.01 then
            fgAnchorPos += move.Unit * S.flySpeed * dt
        end
        -- keep the anchor above the character
        if fgAnchorPos.Y < hrp.Position.Y + 1 then
            fgAnchorPos = Vector3.new(fgAnchorPos.X, hrp.Position.Y + 1, fgAnchorPos.Z)
        end

        -- re-snap and write the hook CFrame so the game's integrator pulls us toward it
        local yaw = math.atan2(-look.X, -look.Z)
        local snapYaw = math.round(yaw / (math.pi/2)) * (math.pi/2)
        local newHook = CFrame.new(fgAnchorPos) * CFrame.Angles(0, snapYaw, 0)

        if (fgLastHook and (newHook.Position - fgLastHook.Position).Magnitude > 0.05) or not fgLastHook then
            pcall(function() s.hook.Value = newHook end)
            fgLastHook = newHook
        end
    end
end))

-- cleanly drop the grapple on respawn
track(LP.CharacterAdded:Connect(function()
    fgInstalled = false
    fgAnchorPos = nil
    fgLastHook = nil
end))

-- ===========================================================================
-- FEATURE: Noclip (smooth AlignPosition-based, like Fly)
-- ===========================================================================
local noclipAP, noclipAO, noclipActive = nil, nil, false

local function noclipGetParts()
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    return char, hrp, hum
end

local function noclipStart()
    local char, hrp, hum = noclipGetParts()
    if not hrp or not hum then return end

    -- kill any residual velocity
    pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)

    -- AlignPosition for smooth position control (like Fly)
    noclipAP = Instance.new("AlignPosition")
    noclipAP.Name = "OP1_NoclipAP"
    noclipAP.Attachment0 = hrp.RootAttachment
    noclipAP.Mode = Enum.PositionAlignmentMode.OneAttachment
    noclipAP.MaxForce = 1e12
    noclipAP.Responsiveness = 200
    noclipAP.RigidityEnabled = false
    noclipAP.Position = hrp.Position
    noclipAP.Parent = hrp

    -- AlignOrientation to prevent unwanted rotation
    noclipAO = Instance.new("AlignOrientation")
    noclipAO.Name = "OP1_NoclipAO"
    noclipAO.Attachment0 = hrp.RootAttachment
    noclipAO.Mode = Enum.OrientationAlignmentMode.OneAttachment
    noclipAO.MaxTorque = 1e12
    noclipAO.Responsiveness = 200
    noclipAO.RigidityEnabled = true
    noclipAO.CFrame = hrp.CFrame
    noclipAO.Parent = hrp

    -- Humanoid won't try to walk or fall
    hum.PlatformStand = true

    -- Disable collisions on all parts
    local char = LP.Character
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.CanCollide = false
                p.CollisionGroup = "OP1_Noclip_A"
            end
        end
    end

    noclipActive = true
end

local function noclipStop()
    if noclipAP then pcall(function() noclipAP:Destroy() end); noclipAP = nil end
    if noclipAO then pcall(function() noclipAO:Destroy() end); noclipAO = nil end
    local char, hrp, hum = noclipGetParts()
    if hum then
        pcall(function() hum.PlatformStand = false end)
    end
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.CanCollide = true
                pcall(function() p.CollisionGroup = "Default" end)
            end
        end
    end
    noclipActive = false
end

getgenv().__op1_unapplyNoclip = noclipStop
getgenv().__op1_applyNoclip = noclipStart

-- Noclip movement: RenderStepped, runs BEFORE physics
track(RunService.RenderStepped:Connect(function(dt)
    if not S.noclipEnabled then
        if noclipActive then noclipStop() end
        return
    end
    if not noclipActive then noclipStart() end
    if not noclipAP or not noclipAP.Parent then return end

    local char, hrp, hum = noclipGetParts()
    if not hrp then noclipStop() return end
    if noclipAP.Parent ~= hrp then
        noclipStop(); noclipStart(); return
    end

    -- Keep Humanoid pinned so it doesn't fight us
    if hum and not hum.PlatformStand then
        hum.PlatformStand = true
    end

    local cam = WS.CurrentCamera
    if not cam then return end

    local look = cam.CFrame.LookVector
    local flatForward = Vector3.new(look.X, 0, look.Z)
    if flatForward.Magnitude < 0.01 then
        local ch = LP.Character
        local hrp2 = ch and ch:FindFirstChild("HumanoidRootPart")
        if hrp2 then
            local f = hrp2.CFrame.LookVector
            flatForward = Vector3.new(f.X, 0, f.Z)
        else
            flatForward = Vector3.new(0, 0, 1)
        end
    end
    flatForward = flatForward.Unit
    local flatRight = flatForward:Cross(Vector3.new(0, 1, 0)).Unit

    local move = Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then move += flatForward end
    if UIS:IsKeyDown(Enum.KeyCode.S) then move -= flatForward end
    if UIS:IsKeyDown(Enum.KeyCode.A) then move -= flatRight end
    if UIS:IsKeyDown(Enum.KeyCode.D) then move += flatRight end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end

    if move.Magnitude > 0.01 then
        noclipAP.Position = noclipAP.Position + move.Unit * S.flySpeed * dt
    end
    -- Keep orientation stable
    noclipAO.CFrame = CFrame.new(noclipAP.Position, noclipAP.Position + cam.CFrame.LookVector)
end))

-- reapply on respawn, state changes, and newly added parts
track(LP.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        track(hum.StateChanged:Connect(function()
            if S.noclipEnabled then task.defer(noclipStart) end
        end))
    end
    track(char.DescendantAdded:Connect(function(d)
        if d:IsA("BasePart") and S.noclipEnabled then
            d.CanCollide = false
            d.CollisionGroup = "OP1_Noclip_A"
        end
    end))
end))
-- ===========================================================================
-- MENU
-- ===========================================================================
Window = Library:Window({ Name = "Operation One", SubTitle = "utility" })
local CombatPage = Window:Page({ Name = "Combat", Icon = "136879043989014" })
local WeaponSub = CombatPage:SubPage({ Name = "Weapon" })
local MovementSub = CombatPage:SubPage({ Name = "Movement" })
local RagebotPage = Window:Page({ Name = "Ragebot", Icon = "136879043989014" })
local RagebotSub = RagebotPage:SubPage({ Name = "Main" })
local VisualsPage = Window:Page({ Name = "Visuals", Icon = "136879043989014" })
local PanelsSub = VisualsPage:SubPage({ Name = "Panels" })
Library:CreateSettingsPage(Window)

local moveSec = MovementSub:Section({ Name = "Movement", Icon = "136879043989014", Side = 2 })

moveSec:Toggle({
    Name = "Fly (Force Grapple)",
    Flag = "op1_fly",
    Default = false,
    Callback = function(v) S.flyEnabled = v end
})
moveSec:Slider({
    Name = "Fly Speed",
    Flag = "op1_flySpeed",
    Min = 10, Max = 400, Default = 60,
    Suffix = "st/s", Decimals = 1,
    Callback = function(v) S.flySpeed = v end
})
moveSec:Slider({
    Name = "Fly Vertical",
    Flag = "op1_flyVert",
    Min = 10, Max = 400, Default = 40,
    Suffix = "st/s", Decimals = 1,
    Callback = function(v) S.flyVerticalSpeed = v end
})
moveSec:Toggle({
    Name = "Noclip",
    Flag = "op1_noclip",
    Default = false,
    Callback = function(v)
        S.noclipEnabled = v
        if v then
            -- Apply noclip: unanchor and disable collision
            local character = LP.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.Anchored = false
                rootPart.CanCollide = false
                -- Keep noclip active while toggle is on
                S.noclipPart = rootPart
            end
        else
            -- Remove noclip: restore properties
            local character = LP.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart and S.noclipPart then
                rootPart.CanCollide = true
                S.noclipPart = nil
            end
        end
    end
})

local gunSec = WeaponSub:Section({ Name = "Gun", Icon = "136879043989014", Side = 1 })
gunSec:Toggle({ Name = "No Spread", Flag = "op1_noSpread", Default = false, Callback = function(v)
	S.noSpread = v
	WS:SetAttribute("__op1_noSpread", v)
	if v then installSilentAimHook() elseif not S.silentAim then uninstallSilentAimHook() end -- hook carries the shot-time spread kill
end })
gunSec:Toggle({ Name = "No Recoil", Flag = "op1_noRecoil", Default = false, Callback = function(v) S.noRecoil = v end })

local aimSec = WeaponSub:Section({ Name = "Silent Aim", Icon = "136879043989014", Side = 2 })
aimSec:Toggle({ Name = "Enabled", Flag = "op1_silentAim", Default = false, Callback = function(v)
	S.silentAim = v; WS:SetAttribute("__op1_saOn", v)
	if v then installSilentAimHook() elseif not S.noSpread then uninstallSilentAimHook() end
end })
aimSec:Toggle({ Name = "Auto Fire", Flag = "op1_autoFire", Default = false, Callback = function(v)
	S.autoFire = v
	-- Auto-fire works when: user enables it AND (silent aim is off OR ragebot is enabled)
	local rbEnabled = S.rbEnabled or false
	if v and (not S.silentAim or rbEnabled) and Library.SetFlags["op1_silentAim"] then
		Library.SetFlags["op1_silentAim"](true)
	end
end })
aimSec:Toggle({ Name = "Wallbang Check", Flag = "op1_saWallbang", Default = false, Callback = function(v) S.saWallbang = v; pushSettings() end })
aimSec:Toggle({ Name = "Visible Check", Flag = "op1_saVisible", Default = true, Callback = function(v) S.saVisible = v; pushSettings() end })
aimSec:Toggle({ Name = "Team Check", Flag = "op1_teamCheck", Default = true, Callback = function(v) S.teamCheck = v; pushSettings() end })
aimSec:Toggle({ Name = "FOV Check", Flag = "op1_saFOVCheck", Default = true, Callback = function(v) S.fovCheck = v; pushSettings() end })
aimSec:Slider({ Name = "FOV", Flag = "op1_saFOV", Min = 1, Max = 1000, Default = 300, Suffix = "px", Decimals = 1, Callback = function(v) S.fov = v; pushSettings() end })
aimSec:Dropdown({ Name = "Priority", Flag = "op1_saPriority", Items = { "Crosshair", "Nearest" }, Default = "Crosshair", Callback = function(v) S.priority = v; pushSettings() end })
	aimSec:Label("Overwrite Key"):Keybind({ Flag = "op1_overwriteKey", Default = Enum.KeyCode.E, Mode = "Hold", Callback = function(toggled) S.overwrite = toggled; WS:SetAttribute("__op1_saOverwrite", toggled) end })

-- Ragebot tab
local rbSec = RagebotSub:Section({ Name = "Ragebot", Icon = "136879043989014", Side = 1 })
rbSec:Toggle({ Name = "Enabled", Flag = "op1_rbEnabled", Default = false, Callback = function(v)
	S.rbEnabled = v
	if v then
		-- Ragebot takes over silent aim - STAYS ON until ragebot is turned off
		S.silentAim = true
		S.rbAutoShoot = true  -- auto-enable auto shoot
		S.rbShotLog = {lastShot = 0, hit = false, targetName = ""} -- shot logging init
		S.killLog = {} -- kill tracking table
		WS:SetAttribute("__op1_saOn", true)
		-- Ragebot deliberately does NOT overwrite the Aim section's Wallbang / Visible /
		-- FOV settings any more: it used to force S.saWallbang = true, S.saVisible = false,
		-- S.fovCheck = false here and the disable path then "restored" from those corrupted
		-- values -- so after one ragebot session Visible Check was permanently off and every
		-- wall/visibility gate silently stopped working. Ragebot's own gates now live in the
		-- render loop: targetable() (Auto Wallbang), team filter and rbVisualCheck.
		pushSettings()
		installSilentAimHook()
	else
		-- Restore silent aim to its own settings when ragebot disabled
		S.silentAim = false
		S.rbAutoShoot = false
		WS:SetAttribute("__op1_saOn", false)
		pushSettings() -- writes __op1_saWallbang / saVisible / saFOV / saMaxAngle back from S.*
		if not S.noSpread then uninstallSilentAimHook() end
	end
end })
rbSec:Toggle({ Name = "Auto Shoot", Flag = "op1_rbAutoShoot", Default = false, Callback = function(v) S.rbAutoShoot = v end })
rbSec:Toggle({ Name = "Auto Wallbang", Flag = "op1_rbAutoWallbang", Default = false, Callback = function(v) S.rbAutoWallbang = v end })
rbSec:Toggle({ Name = "Visual Check", Flag = "op1_rbVisualCheck", Default = true, Callback = function(v) S.rbVisualCheck = v end })
-- MIN DAMAGE SLIDER REMOVED - wallbang/visible now controlled by ragebot settings
rbSec:Dropdown({ Name = "Target Part", Flag = "op1_rbTargetPart", Items = { "Auto", "Head", "Torso", "LowerTorso", "HumanoidRootPart" }, Default = "Auto", Callback = function(v) S.rbTargetPart = v; pushSettings() end })
	rbSec:Slider({ Name = "Max FOV", Flag = "op1_rbFOV", Min = 1, Max = 2000, Default = 1000, Suffix = "px", Decimals = 1, Callback = function(v) S.rbFOV = v end })
	rbSec:Dropdown({ Name = "Priority", Flag = "op1_rbPriority", Items = { "Crosshair", "Nearest" }, Default = "Crosshair", Callback = function(v) S.rbPriority = v; pushSettings() end })
	rbSec:Toggle({ Name = "Auto Stop", Flag = "op1_rbAutoStop", Default = false, Callback = function(v) S.rbAutoStop = v; pushSettings() end })
rbSec:Toggle({ Name = "Auto Crouch", Flag = "op1_rbAutoCrouch", Default = false, Callback = function(v) S.rbAutoCrouch = v; pushSettings() end })

rbSec:Label("--- Manipulation ---")
rbSec:Toggle({
	Name = "Origin Manipulation",
	Flag = "op1_manip",
	Default = false,
	Callback = function(v) S.manip = v end
})
rbSec:Label("Manip Key (hold)"):Keybind({
	Flag = "op1_manipKey",
	Default = Enum.KeyCode.LeftControl,
	Mode = "Hold",
	Callback = function(toggled)
		S.manipKeyHeld = toggled
	end
})
rbSec:Slider({
	Name = "Manip Distance",
	Flag = "op1_manipDist",
	Min = 2,
	Max = 8,
	Default = 4.5,
	Suffix = "st",
	Decimals = 1,
	Callback = function(v) S.manipDist = v end
})
rbSec:Toggle({
	Name = "Auto-Fire When Clear",
	Flag = "op1_manipAutoFire",
	Default = true,
	Callback = function(v) S.manipAutoFire = v end
})

local visSec = PanelsSub:Section({ Name = "Visuals", Icon = "136879043989014", Side = 1 })
visSec:Toggle({ Name = "Enemy Panel", Flag = "op1_enemyPanel", Default = true, Callback = function(v) S.enemyPanel = v; panelGui.Enabled = v end })
visSec:Toggle({ Name = "Hide Frozen (anti-ghost)", Flag = "op1_hideFrozen", Default = true, Callback = function(v) S.hideFrozen = v end })
visSec:Toggle({ Name = "Player ESP (Drawing)", Flag = "op1_drawEsp", Default = false, Callback = function(v) S.drawEsp = v end })
visSec:Toggle({ Name = "  Box", Flag = "op1_drawBox", Default = true, Callback = function(v) S.drawBox = v end })
visSec:Toggle({ Name = "  Health", Flag = "op1_drawHealth", Default = true, Callback = function(v) S.drawHealth = v end })
visSec:Toggle({ Name = "  Name + Distance", Flag = "op1_drawName", Default = true, Callback = function(v) S.drawName = v end })
	visSec:Toggle({ Name = "  Tracer", Flag = "op1_drawTracer", Default = true, Callback = function(v) S.drawTracer = v end })
	visSec:Toggle({ Name = "  Equipped Gun", Flag = "op1_gunEsp", Default = true, Callback = function(v) S.gunEsp = v end })
	visSec:Label("Gun Color"):Colorpicker({ Flag = "op1_gunEspColor", Default = Color3.fromRGB(255, 170, 0), Callback = function(v) S.gunEspColor = v end })
	visSec:Label("ESP Color"):Colorpicker({ Flag = "op1_espColor", Default = Color3.fromRGB(255, 255, 255), Callback = function(v) S.espColor = v end })

visSec:Toggle({ Name = "Skeleton ESP", Flag = "op1_skeleton", Default = false, Callback = function(v) S.skeleton = v end })
visSec:Slider({ Name = "Skeleton Thickness", Flag = "op1_skeletonThickness", Min = 1, Max = 5, Default = 1.5, Suffix = "px", Decimals = 0.5, Callback = function(v) S.skeletonThickness = v end })
visSec:Label("Skeleton Color"):Colorpicker({ Flag = "op1_skeletonColor", Default = Color3.fromRGB(255, 64, 64), Callback = function(v) S.skeletonColor = v end })
visSec:Toggle({ Name = "2D Box ESP", Flag = "op1_boxEsp", Default = false, Callback = function(v) S.boxEsp = v end })
visSec:Toggle({ Name = "Box Fill", Flag = "op1_boxFill", Default = false, Callback = function(v) S.boxFill = v end })
visSec:Slider({ Name = "Box Thickness", Flag = "op1_boxThickness", Min = 1, Max = 5, Default = 1.5, Suffix = "px", Decimals = 0.5, Callback = function(v) S.boxThickness = v end })
visSec:Label("Box Color"):Colorpicker({ Flag = "op1_boxColor", Default = Color3.fromRGB(255, 64, 64), Callback = function(v) S.boxColor = v end })
visSec:Toggle({ Name = "Device ESP (C4/Claymore)", Flag = "op1_deviceEsp", Default = false, Callback = function(v) S.deviceEsp = v end })
visSec:Label("Device Color"):Colorpicker({ Flag = "op1_deviceColor", Default = Color3.fromRGB(255, 170, 0), Callback = function(v) S.deviceColor = v end })
visSec:Toggle({ Name = "Bullet Tracers", Flag = "op1_bulletTracers", Default = false, Callback = function(v) S.bulletTracers = v end })
visSec:Label("Tracer Color"):Colorpicker({ Flag = "op1_tracerColor", Default = Color3.fromRGB(255, 255, 255), Callback = function(v) S.tracerColor = v end })
visSec:Slider({ Name = "Tracer Thickness", Flag = "op1_tracerThickness", Min = 0.05, Max = 1, Default = 0.15, Suffix = "", Decimals = 0.05, Callback = function(v) S.tracerThickness = v end })
visSec:Slider({ Name = "Tracer Lifetime", Flag = "op1_tracerLifetime", Min = 0.1, Max = 5, Default = 1.5, Suffix = "s", Decimals = 0.1, Callback = function(v) S.tracerLifetime = v end })
visSec:Toggle({ Name = "Hitmarker", Flag = "op1_hitmarker", Default = false, Callback = function(v) S.hitmarker = v end })
visSec:Label("Hitmarker Color"):Colorpicker({ Flag = "op1_hitmarkerColor", Default = Color3.fromRGB(255, 255, 255), Callback = function(v) S.hitmarkerColor = v end })
visSec:Slider({ Name = "Hitmarker Size", Flag = "op1_hitmarkerSize", Min = 12, Max = 96, Default = 32, Suffix = "px", Decimals = 1, Callback = function(v) S.hitmarkerSize = v end })

local testSec = PanelsSub:Section({ Name = "Testing", Icon = "136879043989014", Side = 2 })
testSec:Button({ Name = "Spawn Dummy", Callback = function()
	local ok, err = spawnDummy()
	pcall(function() Library:Notification(ok and "Dummy spawned" or ("Dummy failed: " .. tostring(err)), 3, nil) end)
end })
testSec:Button({ Name = "Clear Dummies", Callback = function() clearDummies() end })
testSec:Button({ Name = "Unstick Loading", Callback = function()
    pcall(function()
        if getgenv().__op1Unstick then
            getgenv().__op1Unstick()
        end
    end)
end })
testSec:Button({ Name = "Fix My Character", Callback = function()
	local ok, msg = getgenv().__op1FixChar and getgenv().__op1FixChar()
	pcall(function() Library:Notification((ok and "Character fixed: " or "Fix failed: ") .. tostring(msg), 3, nil) end)
end })
testSec:Button({ Name = "Cleanup Extras", Callback = function()
	local ok, msg = getgenv().__op1CleanMe and getgenv().__op1CleanMe()
	pcall(function() Library:Notification("Cleanup: " .. tostring(msg), 3, nil) end)
end })
testSec:Toggle({ Name = "Auto-Skip Loading", Flag = "op1_autoSkipLoading", Default = false, Callback = function(v) S.autoSkipLoading = v end })
testSec:Slider({ Name = "Dummy Distance", Flag = "op1_dummyDistance", Min = 5, Max = 100, Default = 15, Suffix = "st", Decimals = 1, Callback = function(v) S.dummyDistance = v end })
testSec:Toggle({ Name = "Third Person", Flag = "op1_thirdPerson", Default = false, Callback = function(v) S.thirdPerson = v end })
testSec:Slider({ Name = "TP Distance", Flag = "op1_tpDistance", Min = 1, Max = 40, Default = 12, Suffix = "st", Decimals = 1, Callback = function(v) S.tpDistance = v end })
testSec:Slider({ Name = "TP Height", Flag = "op1_tpHeight", Min = -2, Max = 8, Default = 2, Suffix = "st", Decimals = 1, Callback = function(v) S.tpHeight = v end })
testSec:Toggle({ Name = "First-Person Camera Lock", Flag = "op1_fpLock", Default = false, Callback = function(v) S.fpLock = v end })
testSec:Slider({ Name = "Max Look Pitch", Flag = "op1_fpMaxPitch", Min = 55, Max = 89, Default = 85, Suffix = "deg", Decimals = 0.5, Callback = function(v) S.fpMaxPitch = v end })

-- ===========================================================================
-- FEATURE: Third person camera (proper override: behind + above, hides 1P viewmodel)
-- ===========================================================================
local tpWasOn = false
local tpSavedMode = nil
local tpSavedTrans = {}
local tpSavedVM = {}
local tpBody = nil
local function tpDestroyBody()
	if tpBody then pcall(function() tpBody:Destroy() end); tpBody = nil end
end
local function tpRestore()
	local lvm = WS:FindFirstChild("Viewmodels") and WS.Viewmodels:FindFirstChild("LocalViewmodel")
	if lvm then for _, p in ipairs(lvm:GetDescendants()) do if p:IsA("BasePart") then p.LocalTransparencyModifier = 0 end end end
	for part, t in pairs(tpSavedVM) do if part.Parent then pcall(function() part.Transparency = t end) end end
	tpSavedVM = {}
	for part, t in pairs(tpSavedTrans) do if part.Parent then pcall(function() part.Transparency = t end) end end
	tpSavedTrans = {}
	tpDestroyBody()
	tpWasOn = false
end
local tpBuilding = false
local function tpBuildAvatar()
	if tpBody and tpBody.Parent then return end
	if tpBuilding then return end
	tpBuilding = true
	task.spawn(function()
		local Players = game:GetService("Players")
		local model
		pcall(function()
			local desc = Players:GetHumanoidDescriptionFromUserId(LP.UserId)
			model = Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R6)
		end)
		if model and not (tpBody and tpBody.Parent) then
			model.Name = "OP1_TPBody"
			local hum = model:FindFirstChildOfClass("Humanoid")
			if hum then pcall(function() hum:Destroy() end) end
			for _, p in ipairs(model:GetDescendants()) do
				if p:IsA("BasePart") then
					p.Anchored = true; p.CanCollide = false; p.CanQuery = false; p.CanTouch = false; p.LocalTransparencyModifier = 0
				end
			end
			model.Parent = WS
			tpBody = model
		else
			pcall(function() model:Destroy() end)
		end
		tpBuilding = false
	end)
end
local function tpEnsureBody()
	if tpBody and tpBody.Parent then return tpBody end
	tpBuildAvatar()
	return tpBody
end
local function tpStep(dt)
	local lvm = WS:FindFirstChild("Viewmodels") and WS.Viewmodels:FindFirstChild("LocalViewmodel")
	if not S.thirdPerson then
		if tpWasOn then tpRestore() end
		return
	end
	local cam = WS.CurrentCamera
	local char = LP.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not cam or not root then return end
	tpWasOn = true
	local look = cam.CFrame.LookVector
	local anchor = root.Position + Vector3.new(0, S.tpHeight, 0)
	local camPos = anchor - look * S.tpDistance
	cam.CFrame = CFrame.lookAt(camPos, camPos + look)
	if lvm then
		for _, p in ipairs(lvm:GetDescendants()) do
			if p:IsA("BasePart") then
				if tpSavedVM[p] == nil then tpSavedVM[p] = p.Transparency end
				p.Transparency = 1
				p.LocalTransparencyModifier = 1
			end
		end
	end
	if char then
		for _, p in ipairs(char:GetDescendants()) do
			if p:IsA("BasePart") then
				if tpSavedTrans[p] == nil then tpSavedTrans[p] = p.Transparency end
				p.LocalTransparencyModifier = 0
				if p.Transparency > 0 then p.Transparency = 0 end
			end
		end
	end
	local body = tpEnsureBody()
	if body then
		local flat = Vector3.new(look.X, 0, look.Z)
		if flat.Magnitude < 0.01 then flat = Vector3.new(0, 0, 1) end
		body:PivotTo(CFrame.lookAt(root.Position, root.Position + flat.Unit))
	end
end
RunService:BindToRenderStep("OP1_ThirdPerson", Enum.RenderPriority.Camera.Value + 1, tpStep)
track({ Disconnect = function() pcall(tpRestore); pcall(function() RunService:UnbindFromRenderStep("OP1_ThirdPerson") end) end })

-- ===========================================================================
-- FEATURE: Origin Manipulation via muzzle spoof
-- Probe around camera → if a point can see the target, move the real
-- Shoot/Shot origin there for one frame, fire, then restore.
-- ===========================================================================

local lastManipFire = 0
local spoofSaved = nil -- { inst = Instance, cf = CFrame } or for Attachment: { inst, relative }

local function getMuzzleInst()
	local vms = WS:FindFirstChild("Viewmodels")
	local lvm = vms and vms:FindFirstChild("LocalViewmodel")
	if not lvm then return nil end

	-- Prefer the actual Shot part (matches gun.luau a1.shot)
	local shot = lvm:FindFirstChild("Shot", true)
	if shot and shot:IsA("BasePart") then
		return shot
	end

	-- Fallback: Shoot attachment's parent part
	local shoot = lvm:FindFirstChild("Shoot", true)
	if shoot and shoot:IsA("Attachment") then
		return shoot.Parent -- usually Root / Barrel root
	end

	return nil
end

local function canSeeFrom(fromPos, targetPos, ignore)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = ignore

	local delta = targetPos - fromPos
	if delta.Magnitude < 0.5 then return true end

	local hit = WS:Raycast(fromPos, delta, params)
	if not hit then return true end
	return (hit.Position - targetPos).Magnitude < 2.5
end

local function findClearOrigin(targetPos)
	local cam = WS.CurrentCamera
	if not cam then return nil end

	local camPos = cam.CFrame.Position
	local ignore = getIgnore()
	local dist = math.clamp(S.manipDist or 3, 1, 5) -- keep short; validate is strict

	if canSeeFrom(camPos, targetPos, ignore) then
		return nil -- already visible, no spoof needed
	end

	local cf = cam.CFrame
	local r, u, l = cf.RightVector, cf.UpVector, cf.LookVector
	local dirs = {
		r, -r, l,
		(r + l).Unit, (-r + l).Unit,
		(r + u * 0.3).Unit, (-r + u * 0.3).Unit,
		(l + u * 0.25).Unit,
	}

	local wallParams = RaycastParams.new()
	wallParams.FilterType = Enum.RaycastFilterType.Exclude
	wallParams.FilterDescendantsInstances = ignore

	for _, dir in ipairs(dirs) do
		for step = 0.35, dist, 0.35 do
			local wall = WS:Raycast(camPos, dir * step, wallParams)
			if wall and wall.Distance < step - 0.05 then
				break
			end
			local probe = camPos + dir * step
			if canSeeFrom(probe, targetPos, ignore) then
				return probe
			end
		end
	end
	return nil
end

local function restoreMuzzle()
	if not spoofSaved then return end
	local inst = spoofSaved.inst
	if inst and inst.Parent then
		pcall(function()
			if inst:IsA("BasePart") then
				inst.CFrame = spoofSaved.cf
			end
		end)
	end
	spoofSaved = nil
end

local function spoofMuzzleTo(origin, targetPos)
	restoreMuzzle()

	local muzzle = getMuzzleInst()
	if not muzzle or not muzzle:IsA("BasePart") then
		return false
	end

	spoofSaved = { inst = muzzle, cf = muzzle.CFrame }

	-- move origin only; keep it looking at the target
	pcall(function()
		muzzle.CFrame = CFrame.lookAt(origin, targetPos)
	end)
	return true
end

track(RunService.RenderStepped:Connect(function()
	-- always restore previous frame's spoof first
	restoreMuzzle()

	WS:SetAttribute("__op1_manipOrigin", nil)
	WS:SetAttribute("__op1_manipT", 0)

	if not S.manip or not S.manipKeyHeld then return end

	local cam = WS.CurrentCamera
	if not cam then return end

	-- nearest on-screen enemy (ignore visible check)
	local bestPos, bestDist = nil, math.huge
	for _, e in ipairs(getEnemies()) do
		local aim = aimPartOf(e)
		if aim then
			local sp = cam:WorldToViewportPoint(aim.Position)
			if sp.Z > 0 then
				local d = (Vector2.new(sp.X, sp.Y) - cam.ViewportSize * 0.5).Magnitude
				if d < bestDist then
					bestDist = d
					bestPos = aim.Position
				end
			end
		end
	end
	if not bestPos then return end

	local clearOrigin = findClearOrigin(bestPos)
	if not clearOrigin then return end

	-- spoof muzzle to the clear point THIS FRAME
	if not spoofMuzzleTo(clearOrigin, bestPos) then return end

	WS:SetAttribute("__op1_manipOrigin", clearOrigin)
	WS:SetAttribute("__op1_manipT", os.clock())
	WS:SetAttribute("__op1_saAimAt", bestPos)
	WS:SetAttribute("__op1_saAimAtT", os.clock())

	if S.manipAutoFire and (not Window or not Window.IsOpen) then
		local now = os.clock()
		if now - lastManipFire > 0.08 then
			lastManipFire = now
			pcall(function() mouse1press() end)
			task.delay(0.025, function()
				pcall(function() mouse1release() end)
			end)
		end
	end
end))

-- on respawn, clean up any stale third-person bodies
track(LP.CharacterAdded:Connect(function()
	task.wait(0.5)
	pcall(tpDestroyBody)
end))

-- ===========================================================================
-- FEATURE: First-person camera lock (masks the game's first-person camera spin)
-- ===========================================================================
RunService:BindToRenderStep("OP1_FPLock", Enum.RenderPriority.Camera.Value + 1, function()
	if not S.fpLock then return end
	local char = LP.Character
	if not char or not char:FindFirstChildOfClass("Humanoid") or not char:FindFirstChild("HumanoidRootPart") then return end
	local cam = WS.CurrentCamera
	if not cam then return end
	local cf = cam.CFrame
	local look = cf.LookVector
	local yaw = math.atan2(-look.X, -look.Z)
	local pitch = math.asin(math.clamp(look.Y, -1, 1))
	local maxP = math.rad(S.fpMaxPitch)
	pitch = math.clamp(pitch, -maxP, maxP)
	local cp = math.cos(pitch)
	local newLook = Vector3.new(-math.sin(yaw) * cp, math.sin(pitch), -math.cos(yaw) * cp)
	cam.CFrame = CFrame.lookAt(cf.Position, cf.Position + newLook, Vector3.new(0, 1, 0))
end)
track({ Disconnect = function() pcall(function() RunService:UnbindFromRenderStep("OP1_FPLock") end) end })

-- ===========================================================================
-- FEATURE: Loading unstick (game occasionally hangs on the loading screen)
-- ===========================================================================
local function unstickLoading()
	pcall(function()
		local L = require(game:GetService("ReplicatedStorage").Modules.Loading)
		pcall(function() L.stop() end)
		pcall(function() L.transition_off() end)
		pcall(function() L.is_loading:set(false) end)
	end)
	pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		local lg = pg and pg:FindFirstChild("Loading")
		if lg then
			lg.Enabled = false
			for _, c in ipairs(lg:GetDescendants()) do if c:IsA("GuiObject") then c.Visible = false end end
		end
	end)
end
getgenv().__op1Unstick = unstickLoading
-- rebuild a broken character rig (game's load_character sometimes spawns you with no body parts)
local function fixCharacter()
	local ch = LP.Character
	if not ch then return false, "no character" end
	local hum = ch:FindFirstChildOfClass("Humanoid")
	if not hum then return false, "no humanoid" end
	local template
	for _, m in ipairs(WS:GetChildren()) do
		if m:IsA("Model") and m ~= ch and m.Name ~= LP.Name and m:FindFirstChildOfClass("Humanoid") and m:FindFirstChild("HumanoidRootPart") then template = m break end
	end
	if not template then return false, "no template character found" end
	local tRef = template:FindFirstChild("HumanoidRootPart")
	local aref = ch:FindFirstChild("HumanoidRootPart")
	local basePos = aref and aref.Position or tRef.Position
	local made = 0
	for _, name in ipairs({ "HumanoidRootPart", "legs", "collision" }) do
		if not ch:FindFirstChild(name) then
			local src = template:FindFirstChild(name)
			if src then
				local c = src:Clone()
				c.CFrame = CFrame.new(basePos) * (src.CFrame - src.CFrame.Position)
				c.Anchored = false; c.CanCollide = false
				c.Parent = ch
				made = made + 1
			end
		end
	end
	local nr = ch:FindFirstChild("HumanoidRootPart")
	if nr then pcall(function() hum.RootPart = nr end) end
	return true, "rebuilt " .. made .. " parts"
end
getgenv().__op1FixChar = fixCharacter
-- remove stray/duplicate character models named after you (keeps the real one)
local function cleanupMe()
	local kept = LP.Character
	local n = 0
	for _, m in ipairs(WS:GetChildren()) do
		if m:IsA("Model") and m.Name == LP.Name and m ~= kept then pcall(function() m:Destroy() end); n = n + 1 end
	end
	local vm = WS:FindFirstChild("Viewmodels")
	local localVM = vm and vm:FindFirstChild("LocalViewmodel")
	if localVM then
		local seen = {}
		for _, c in ipairs(localVM:GetChildren()) do
			if c.Name == "YouHighlight" then
				if seen[c.Name] then pcall(function() c:Destroy() end); n = n + 1 else seen[c.Name] = true end
			end
		end
	end
	return true, "removed " .. n .. " duplicates"
end
getgenv().__op1CleanMe = cleanupMe
local loadingStuckFor = 0
track(RunService.RenderStepped:Connect(function(dt)
	if not S.autoSkipLoading then loadingStuckFor = 0 return end
	local pg = LP:FindFirstChild("PlayerGui")
	local lg = pg and pg:FindFirstChild("Loading")
	local stuck = false
	if lg and lg.Enabled then
		for _, c in ipairs(lg:GetDescendants()) do
			if c:IsA("GuiObject") and c.Visible then stuck = true break end
		end
	end
	loadingStuckFor = stuck and (loadingStuckFor + dt) or 0
	if loadingStuckFor > 8 then
		loadingStuckFor = 0
		unstickLoading()
	end
end))

local oldUnload = Library.Unload
Library.Unload = function(self)
	pcall(cleanup)
	return oldUnload(self)
end

Library:Notification("Operation One menu loaded", 4, nil)
