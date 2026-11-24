-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local GetFFlagTextChatEnableUniverseChatTabs = require(scriptParentParent.ExpChatShared).Flags.GetFFlagTextChatEnableUniverseChatTabs
local getFFlagExpChatProtectedChatInternalAPIs = require(scriptParentParent.SharedFlags).getFFlagExpChatProtectedChatInternalAPIs

local function startDebug()
    local CoreGui = game:GetService("CoreGui")
    local TextChatService = game:GetService("TextChatService")
    local engineFeature = game:GetEngineFeature("ExpChatDebuggerIncomingMessageEvent")
    local bool1 = game:DefineFastFlag("ExpChatDebugGlobalChat", false)

    local experienceChatDebug = Instance.new("ScreenGui")
    experienceChatDebug.Name = "ExperienceChatDebug"
    experienceChatDebug.ResetOnSpawn = false
    experienceChatDebug.DisplayOrder = -1
    experienceChatDebug.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local num1 = 7
    local tbl1 = {
        {
            vertical = Enum.VerticalAlignment.Top,
            horizontal = Enum.HorizontalAlignment.Left
        },
        {
            vertical = Enum.VerticalAlignment.Top,
            horizontal = Enum.HorizontalAlignment.Center
        },
        {
            vertical = Enum.VerticalAlignment.Top,
            horizontal = Enum.HorizontalAlignment.Right
        },
        {
            vertical = Enum.VerticalAlignment.Center,
            horizontal = Enum.HorizontalAlignment.Left
        },
        {
            vertical = Enum.VerticalAlignment.Center,
            horizontal = Enum.HorizontalAlignment.Center
        },
        {
            vertical = Enum.VerticalAlignment.Center,
            horizontal = Enum.HorizontalAlignment.Right
        },
        {
            vertical = Enum.VerticalAlignment.Bottom,
            horizontal = Enum.HorizontalAlignment.Left
        },
        {
            vertical = Enum.VerticalAlignment.Bottom,
            horizontal = Enum.HorizontalAlignment.Center
        },
        {
            vertical = Enum.VerticalAlignment.Bottom,
            horizontal = Enum.HorizontalAlignment.Right
        }
    }

    local tbl2 = {}

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Parent = experienceChatDebug

    local function updateContainerLayout() -- Luacid: Inlined by compiler; 2 call sites recovered
        local var1 = tbl1[num1]
        uiListLayout.VerticalAlignment = var1.vertical
        uiListLayout.HorizontalAlignment = var1.horizontal
    end

    updateContainerLayout()
    local imageButton = Instance.new("ImageButton")
    imageButton.AutomaticSize = Enum.AutomaticSize.XY
    imageButton.Size = UDim2.new(0, 200, 0, 20)
    imageButton.BackgroundTransparency = 0.3
    imageButton.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    imageButton.Parent = experienceChatDebug

    imageButton.Activated:Connect(function()
        num1 += 1
        if num1 > #tbl1 then
            num1 = 1
        end

        updateContainerLayout()
    end)

    local function clearEntries()
        for _, value in tbl2 do
            value:Destroy()
        end
        tbl2 = {}
    end
    imageButton.MouseButton2Click:Connect(clearEntries)
    imageButton.TouchLongPress:Connect(clearEntries)

    local uiListLayout2 = Instance.new("UIListLayout")
    uiListLayout2.VerticalAlignment = Enum.VerticalAlignment.Bottom
    uiListLayout2.Parent = imageButton

    local function addEntryToContainer(textLabelText: string, backgroundColor3: Color3, backgroundTransparency: number)
        if #tbl2 > 10 then
            local var1 = table.remove(tbl2, 1)
            if var1 then
                var1:Destroy()
            end
        end

        local textLabel = Instance.new("TextLabel")
        textLabel.AutomaticSize = Enum.AutomaticSize.X
        textLabel.BackgroundTransparency = backgroundTransparency
        textLabel.BackgroundColor3 = backgroundColor3
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.Text = textLabelText
        textLabel.RichText = true
        textLabel.TextTruncate = Enum.TextTruncate.AtEnd
        textLabel.TextYAlignment = Enum.TextYAlignment.Top
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.TextSize = 16
        textLabel.FontFace = Font.fromEnum(Enum.Font.RobotoMono)
        textLabel.Size = UDim2.new(0, 0, 0, 18)
        textLabel.Parent = imageButton

        table.insert(tbl2, textLabel)
    end

    local str1 = utf8.char(128227)
    local str2 = utf8.char(128229)

    local function formatEntry(textChatMessage: TextChatMessage, str3: string)
        local str4 = if textChatMessage.Status == Enum.TextChatMessageStatus.Sending then `{str1} Sent` else `{str2} Rec.`
        local str5 = if str3 == "Global" then "RBXGlobal" elseif not textChatMessage.TextChannel or str3 ~= "Local" then "Unknown" else textChatMessage.TextChannel.Name

        local bool2 = textChatMessage.Status ~= Enum.TextChatMessageStatus.Success
            and textChatMessage.Status ~= Enum.TextChatMessageStatus.Sending

        local str6 = if bool2 then `({textChatMessage.Status.Name})` else ""
        local color3 = if bool2 then Color3.fromRGB(255, 0, 0) else Color3.fromRGB(32, 32, 32)
        local num2 = if bool2 then 0.5 else 1
        local str7 = if textChatMessage.TextChannel and textChatMessage.TextChannel.DirectChatRequester then " <font color='#00E344'>(Direct)</font>" else ""
        local str8 = if getFFlagExpChatProtectedChatInternalAPIs() then textChatMessage.TextInternal else textChatMessage.Text
        addEntryToContainer(`{str4} [{str5}{str7}] {str8} {str6}`, color3, num2)
    end

    if engineFeature then
        TextChatService.OnIncomingMessageEvent:Connect(function(textChatMessage: TextChatMessage)
            formatEntry(textChatMessage, "Local")
        end)
    else
        TextChatService.MessageReceived:Connect(function(textChatMessage: TextChatMessage)
            formatEntry(textChatMessage, "Local")
        end)
        TextChatService.SendingMessage:Connect(function(textChatMessage: TextChatMessage)
            formatEntry(textChatMessage, "Local")
        end)
    end

    if GetFFlagTextChatEnableUniverseChatTabs() and bool1 then
        TextChatService.UniverseChatMessageReceived:Connect(function(textChatMessage: TextChatMessage)
            formatEntry(textChatMessage, "Global")
        end)
    end

    experienceChatDebug.Parent = CoreGui
end

return startDebug
