-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Chat = game:GetService("Chat")
local TextService = game:GetService("TextService")

local LocalPlayer = Players.LocalPlayer
while LocalPlayer == nil do
    Players.ChildAdded:wait()
    LocalPlayer = Players.LocalPlayer
end

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserShouldLocalizeGameChatBubble")
end)
local var1 = success and result

local success2, result2 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFixBubbleChatText")
end)
local var2 = success2 and result2

local success3, result3 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserRoactBubbleChatBeta")
end)
local var3 = success3 and result3

local success4, result4 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserPreventOldBubbleChatOverlap")
end)
local var4 = success4 and result4

local function getMessageLength(arg1): (number?, number?) -- Luacid: Inlined by compiler; 6 call sites recovered
    return utf8.len(utf8.nfcnormalize(arg1))
end

local SourceSans = Enum.Font.SourceSans
local Size24 = Enum.FontSize.Size24
local var5 = 128 - getMessageLength("...") - 1

local tbl1 = { WHITE = "dub", BLUE = "blu", GREEN = "gre", RED = "red" }

local BubbleChat = Instance.new("ScreenGui")
BubbleChat.Name = "BubbleChat"
BubbleChat.ResetOnSpawn = false
BubbleChat.Parent = PlayerGui

local function lerpLength(arg1, arg2, arg3) -- Luacid: unused: defined but never referenced
    return arg2 + (arg3 - arg2) * math.min(getMessageLength(arg1) / 75, 1)
end

local function createFifo()
    local module = {
        data = {}
    }
    local bindableEvent = Instance.new("BindableEvent")
    module.Emptied = bindableEvent.Event

    function module.Size(_): number
        return #module.data
    end

    function module.Empty(_): boolean
        return module:Size() <= 0
    end

    function module.PopFront(_)
        table.remove(module.data, 1)
        if module:Empty() then
            bindableEvent:Fire()
        end
    end
    function module.Front(_)
        return module.data[1]
    end

    function module.Get(_, arg1)
        return module.data[arg1]
    end

    function module.PushBack(_, arg1)
        table.insert(module.data, arg1)
    end

    function module.GetData(_)
        return module.data
    end

    return module
end

local function createCharacterChats() -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        Fifo = createFifo(),
        BillboardGui = nil
    }
end

local function createChatLine(message, bubbleColor: string, isLocalPlayer)
    local tbl2 = {
        ComputeBubbleLifetime = function(_, message2, isLocalPlayer2): number
            if isLocalPlayer2 then
                return 8 + 7 * math.min(getMessageLength(message2) / 75, 1)
            end

            return 12 + 8 * math.min(getMessageLength(message2) / 75, 1)
        end,
        Origin = nil,
        RenderBubble = nil,
        Message = message
    }

    tbl2.BubbleDieDelay = tbl2:ComputeBubbleLifetime(message, isLocalPlayer)
    tbl2.BubbleColor = bubbleColor
    tbl2.IsLocalPlayer = isLocalPlayer

    return tbl2
end

local function createPlayerChatLine(arg1, message, isLocalPlayer) -- Luacid: unused: defined but never referenced
    local chatLine = createChatLine(message, "dub", isLocalPlayer)

    if arg1 then
        chatLine.User = arg1.Name
        chatLine.Origin = arg1.Character
    end

    return chatLine
end

local function createGameChatLine(origin: BasePart, message, isLocalPlayer: boolean, bubbleColor: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local chatLine = createChatLine(message, bubbleColor, isLocalPlayer)
    chatLine.Origin = origin

    return chatLine
end

function createChatBubbleMain(arg1, sliceCenter): ImageLabel
    local chatBubble = Instance.new("ImageLabel")
    chatBubble.Name = "ChatBubble"
    chatBubble.ScaleType = Enum.ScaleType.Slice
    chatBubble.SliceCenter = sliceCenter
    chatBubble.Image = "rbxasset://textures/" .. tostring(arg1) .. ".png"
    chatBubble.BackgroundTransparency = 1
    chatBubble.BorderSizePixel = 0
    chatBubble.Size = UDim2.new(1, 0, 1, 0)
    chatBubble.Position = UDim2.new(0, 0, 0, 0)

    return chatBubble
end

function createChatBubbleTail(chatBubbleTailPosition, chatBubbleTailSize): ImageLabel
    local chatBubbleTail = Instance.new("ImageLabel")
    chatBubbleTail.Name = "ChatBubbleTail"
    chatBubbleTail.Image = "rbxasset://textures/ui/dialog_tail.png"
    chatBubbleTail.BackgroundTransparency = 1
    chatBubbleTail.BorderSizePixel = 0
    chatBubbleTail.Position = chatBubbleTailPosition
    chatBubbleTail.Size = chatBubbleTailSize

    return chatBubbleTail
end

function createChatBubbleWithTail(arg1, arg2, arg3, arg4)
    local chatBubbleMain = createChatBubbleMain(arg1, arg4)

    createChatBubbleTail(arg2, arg3).Parent = chatBubbleMain

    return chatBubbleMain
end

function createScaledChatBubbleWithTail(arg1, num1: number?, arg2, arg3)
    local chatBubbleMain = createChatBubbleMain(arg1, arg3)

    local chatBubbleTailFrame = Instance.new("Frame")
    chatBubbleTailFrame.Name = "ChatBubbleTailFrame"
    chatBubbleTailFrame.BackgroundTransparency = 1
    chatBubbleTailFrame.SizeConstraint = Enum.SizeConstraint.RelativeXX
    chatBubbleTailFrame.Position = UDim2.new(0.5, 0, 1, 0)
    chatBubbleTailFrame.Size = UDim2.new(num1, 0, num1, 0)
    chatBubbleTailFrame.Parent = chatBubbleMain

    createChatBubbleTail(arg2, UDim2.new(1, 0, 0.5, 0)).Parent = chatBubbleTailFrame

    return chatBubbleMain
end

function createChatImposter(arg1, arg2, yScale: number?): ImageLabel
    local dialogPlaceholder = Instance.new("ImageLabel")
    dialogPlaceholder.Name = "DialogPlaceholder"
    dialogPlaceholder.Image = "rbxasset://textures/" .. tostring(arg1) .. ".png"
    dialogPlaceholder.BackgroundTransparency = 1
    dialogPlaceholder.BorderSizePixel = 0
    dialogPlaceholder.Position = UDim2.new(0, 0, -1.25, 0)
    dialogPlaceholder.Size = UDim2.new(1, 0, 1, 0)

    local dotDotDot = Instance.new("ImageLabel")
    dotDotDot.Name = "DotDotDot"
    dotDotDot.Image = "rbxasset://textures/" .. tostring(arg2) .. ".png"
    dotDotDot.BackgroundTransparency = 1
    dotDotDot.BorderSizePixel = 0
    dotDotDot.Position = UDim2.new(0.001, 0, yScale, 0)
    dotDotDot.Size = UDim2.new(1, 0, 0.7, 0)
    dotDotDot.Parent = dialogPlaceholder

    return dialogPlaceholder
end

local tbl2 = {
    ChatBubble = {},
    ChatBubbleWithTail = {},
    ScalingChatBubbleWithTail = {},
    CharacterSortedMsg = (function() -- name: createMap
        local module = {
            data = {}
        }
        local num1 = 0

        function module.Size(_)
            return num1
        end

        function module:Erase(arg1)
            if module.data[arg1] then
                num1 -= 1
            end

            module.data[arg1] = nil
        end

        function module.Set(_, arg1, arg2)
            module.data[arg1] = arg2
            if arg2 then
                num1 += 1
            end
        end
        function module:Get(arg1)
            if not arg1 then
                return
            end

            if not module.data[arg1] then
                module.data[arg1] = createCharacterChats()
                local connection = nil
                connection = module.data[arg1].Fifo.Emptied:connect(function()
                    connection:disconnect()
                    module:Erase(arg1)
                end)
            end
            return module.data[arg1]
        end

        function module:GetData()
            return module.data
        end

        return module
    end)()
}

local function initChatBubbleType(str1: string, str2: string, _: string, bool1: boolean, rect: Rect)
    tbl2.ChatBubble[str1] = createChatBubbleMain(str2, rect)
    tbl2.ChatBubbleWithTail[str1] = createChatBubbleWithTail(str2, UDim2.new(0.5, -14, 1, if bool1 then -1 else 0), UDim2.new(0, 30, 0, 14), rect)
    tbl2.ScalingChatBubbleWithTail[str1] = createScaledChatBubbleWithTail(str2, 0.5, UDim2.new(-0.5, 0, 0, if bool1 then -1 else 0), rect)
end

initChatBubbleType("dub", "ui/dialog_white", "ui/chatBubble_white_notify_bkg", false, Rect.new(5, 5, 15, 15))
initChatBubbleType("blu", "ui/dialog_blue", "ui/chatBubble_blue_notify_bkg", true, Rect.new(7, 7, 33, 33))
initChatBubbleType("red", "ui/dialog_red", "ui/chatBubble_red_notify_bkg", true, Rect.new(7, 7, 33, 33))
initChatBubbleType("gre", "ui/dialog_green", "ui/chatBubble_green_notify_bkg", true, Rect.new(7, 7, 33, 33))

function tbl2:SanitizeChatLine(message: string): string
    if not (getMessageLength(message) > var5) then
        return message
    end

    return string.sub(message, 1, utf8.offset(message, var5 + getMessageLength("...") + 1) - 1)
end

local function createBillboardInstance(basePart: BasePart): BillboardGui
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Adornee = basePart
    billboardGui.Size = UDim2.new(0, 400, 0, 250)
    billboardGui.StudsOffset = Vector3.new(0, 1.5, 2)
    billboardGui.Parent = BubbleChat

    local billboardFrame = Instance.new("Frame")
    billboardFrame.Name = "BillboardFrame"
    billboardFrame.Size = UDim2.new(1, 0, 1, 0)
    billboardFrame.Position = UDim2.new(0, 0, -0.5, 0)
    billboardFrame.BackgroundTransparency = 1
    billboardFrame.Parent = billboardGui

    local connection = nil
    connection = billboardFrame.ChildRemoved:connect(function()
        if #billboardFrame:GetChildren() <= 1 then
            connection:disconnect()
            billboardGui:Destroy()
        end
    end)

    tbl2:CreateSmallTalkBubble("dub").Parent = billboardFrame

    return billboardGui
end

function tbl2:CreateBillboardGuiHelper(character, bool1: boolean)
    if not character or tbl2.CharacterSortedMsg:Get(character).BillboardGui then
        return
    end

    if not bool1 and character:IsA("BasePart") then
        local billboardGui = createBillboardInstance(character)
        tbl2.CharacterSortedMsg:Get(character).BillboardGui = billboardGui
        return
    end

    if not character:IsA("Model") then
        return
    end

    local head = character:FindFirstChild("Head")
    if head and head:IsA("BasePart") then
        local billboardGui = createBillboardInstance(head)
        tbl2.CharacterSortedMsg:Get(character).BillboardGui = billboardGui
    end
end

local function distanceToBubbleOrigin(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 then
        return (arg1.Position - game.Workspace.CurrentCamera.CoordinateFrame.Position).magnitude
    end

    return 100000
end

local function isPartOfLocalPlayer(adornee) -- Luacid: Inlined by compiler; 2 call sites recovered
    if adornee and Players.LocalPlayer.Character then
        return adornee:IsDescendantOf(Players.LocalPlayer.Character)
    end
end

function tbl2:SetBillboardLODNear(billboardGui)
    local var6 = isPartOfLocalPlayer(billboardGui.Adornee)
    billboardGui.Size = UDim2.new(0, 400, 0, 250)
    billboardGui.StudsOffset = Vector3.new(0, if var6 then 1.5 else 2.5, if var6 then 2 else 0.1)
    billboardGui.Enabled = true
    local children = billboardGui.BillboardFrame:GetChildren()
    for i = 1, #children do
        children[i].Visible = true
    end
    billboardGui.BillboardFrame.SmallTalkBubble.Visible = false
end

function tbl2:SetBillboardLODDistant(billboardGui)
    local var6 = isPartOfLocalPlayer(billboardGui.Adornee)
    billboardGui.Size = UDim2.new(4, 0, 3, 0)
    billboardGui.StudsOffset = Vector3.new(0, 3, if var6 then 2 else 0.1)
    billboardGui.Enabled = true
    local children = billboardGui.BillboardFrame:GetChildren()
    for i = 1, #children do
        children[i].Visible = false
    end
    billboardGui.BillboardFrame.SmallTalkBubble.Visible = true
end

function tbl2:SetBillboardLODVeryFar(billboardGui)
    billboardGui.Enabled = false
end

function tbl2:SetBillboardGuiLOD(billboardGui, arg1)
    if not arg1 then
        return
    end
    if arg1:IsA("Model") then
        arg1 = arg1:FindFirstChild("Head") or arg1.PrimaryPart
    end

    local var6 = distanceToBubbleOrigin(arg1)

    if var6 < 65 then
        tbl2:SetBillboardLODNear(billboardGui)
    elseif var6 >= 65 and var6 < 100 then
        tbl2:SetBillboardLODDistant(billboardGui)
    else
        tbl2:SetBillboardLODVeryFar(billboardGui)
    end
end

function tbl2:CameraCFrameChanged()
    for k, value in pairs(tbl2.CharacterSortedMsg:GetData()) do
        local billboardGui = value.BillboardGui
        if billboardGui then
            tbl2:SetBillboardGuiLOD(billboardGui, k)
        end
    end
end

function tbl2:CreateBubbleText(bubbleTextText, autoLocalize): TextLabel
    local bubbleText = Instance.new("TextLabel")
    bubbleText.Name = "BubbleText"
    bubbleText.BackgroundTransparency = 1

    if var2 then
        bubbleText.Size = UDim2.fromScale(1, 1)
    else
        bubbleText.Position = UDim2.new(0, 15, 0, 0)
        bubbleText.Size = UDim2.new(1, -30, 1, 0)
    end

    bubbleText.Font = SourceSans
    bubbleText.ClipsDescendants = true
    bubbleText.TextWrapped = true
    bubbleText.FontSize = Size24
    bubbleText.Text = bubbleTextText
    bubbleText.Visible = false
    bubbleText.AutoLocalize = autoLocalize

    if var2 then
        local uiPadding = Instance.new("UIPadding")
        uiPadding.PaddingTop = UDim.new(0, 12)
        uiPadding.PaddingRight = UDim.new(0, 12)
        uiPadding.PaddingBottom = UDim.new(0, 12)
        uiPadding.PaddingLeft = UDim.new(0, 12)
        uiPadding.Parent = bubbleText
    end

    return bubbleText
end

function tbl2:CreateSmallTalkBubble(str1: string)
    local clone = tbl2.ScalingChatBubbleWithTail[str1]:Clone()
    clone.Name = "SmallTalkBubble"
    clone.AnchorPoint = Vector2.new(0, 0.5)
    clone.Position = UDim2.new(0, 0, 0.5, 0)
    clone.Visible = false
    local var6 = tbl2:CreateBubbleText("...")
    var6.TextScaled = true
    var6.TextWrapped = false
    var6.Visible = true
    var6.Parent = clone

    return clone
end

function tbl2:UpdateChatLinesForOrigin(origin, arg1)
    local fifo = tbl2.CharacterSortedMsg:Get(origin).Fifo
    local var6 = fifo:Size()
    local data = fifo:GetData()
    if #data <= 1 then
        return
    end
    for i = #data - 1, 1, -1 do
        local renderBubble = data[i].RenderBubble
        if not renderBubble then
            return
        end

        if var6 - i + 1 > 1 then
            local chatBubbleTail = renderBubble:FindFirstChild("ChatBubbleTail")
            if chatBubbleTail then
                chatBubbleTail:Destroy()
            end

            local bubbleText = renderBubble:FindFirstChild("BubbleText")
            if bubbleText then
                bubbleText.TextTransparency = 0.5
            end
        end
        renderBubble:TweenPosition(
            UDim2.new(renderBubble.Position.X.Scale, renderBubble.Position.X.Offset, 1, arg1 - renderBubble.Size.Y.Offset - 14),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Bounce,
            0.1,
            true
        )
        arg1 = arg1 - renderBubble.Size.Y.Offset - 14
    end
end

function tbl2:DestroyBubble(fifo, renderBubble)
    if not fifo or fifo:Empty() then
        return
    end

    local renderBubble2 = fifo:Front().RenderBubble
    if not renderBubble2 then
        fifo:PopFront()
        return
    end

    spawn(function()
        while fifo:Front().RenderBubble ~= renderBubble do
            wait()
        end

        renderBubble2 = fifo:Front().RenderBubble

        local bubbleText = renderBubble2:FindFirstChild("BubbleText")
        local chatBubbleTail = renderBubble2:FindFirstChild("ChatBubbleTail")

        while renderBubble2 and renderBubble2.ImageTransparency < 1 do
            local var6 = wait()
            if not renderBubble2 then
                continue
            end

            local var7 = var6 * 1.5
            renderBubble2.ImageTransparency += var7
            if bubbleText then
                bubbleText.TextTransparency += var7
            end

            if chatBubbleTail then
                chatBubbleTail.ImageTransparency += var7
            end
        end

        if renderBubble2 then
            renderBubble2:Destroy()
            fifo:PopFront()
        end
    end)
end

function tbl2:CreateChatLineRender(character, arg1, bool1: boolean, fifo, autoLocalize: boolean)
    if not character then
        return
    end
    if not tbl2.CharacterSortedMsg:Get(character).BillboardGui then
        tbl2:CreateBillboardGuiHelper(character, bool1)
    end

    local billboardGui = tbl2.CharacterSortedMsg:Get(character).BillboardGui
    if not billboardGui then
        return
    end

    local renderBubble = tbl2.ChatBubbleWithTail[arg1.BubbleColor]:Clone()
    renderBubble.Visible = false
    local var6 = tbl2:CreateBubbleText(arg1.Message, autoLocalize)

    var6.Parent = renderBubble
    renderBubble.Parent = billboardGui.BillboardFrame

    arg1.RenderBubble = renderBubble

    local vector2 = TextService:GetTextSize(var6.Text, 24, SourceSans, Vector2.new(400, 250))
    local num1 = vector2.Y / 24

    if var2 then
        local xOffset = math.ceil(vector2.X + 24)
        local yOffset = num1 * 34

        renderBubble.Size = UDim2.fromOffset(0, 0)
        renderBubble.Position = UDim2.fromScale(0.5, 1)

        renderBubble:TweenSizeAndPosition(
            UDim2.fromOffset(xOffset, yOffset),
            UDim2.new(0.5, -xOffset / 2, 1, -yOffset),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Elastic,
            0.1,
            true,
            function()
                var6.Visible = true
            end
        )

        tbl2:SetBillboardGuiLOD(billboardGui, arg1.Origin)
        tbl2:UpdateChatLinesForOrigin(arg1.Origin, -yOffset)
    else
        local xScale = math.max((vector2.X + 30) / 400, 0.1)

        renderBubble.Size = UDim2.new(0, 0, 0, 0)
        renderBubble.Position = UDim2.new(0.5, 0, 1, 0)

        local yOffset = num1 * 34

        renderBubble:TweenSizeAndPosition(
            UDim2.new(xScale, 0, 0, yOffset),
            UDim2.new((1 - xScale) / 2, 0, 1, -yOffset),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Elastic,
            0.1,
            true,
            function()
                var6.Visible = true
            end
        )
        tbl2:SetBillboardGuiLOD(billboardGui, arg1.Origin)
        tbl2:UpdateChatLinesForOrigin(arg1.Origin, -yOffset)
    end

    delay(arg1.BubbleDieDelay, function()
        tbl2:DestroyBubble(fifo, renderBubble)
    end)
end

function tbl2:OnPlayerChatMessage(arg1, message, _)
    if not tbl2:BubbleChatEnabled() then
        return
    end
    local localPlayer = Players.LocalPlayer
    local bool1 = not (localPlayer == nil) and arg1 ~= localPlayer
    local var6 = tbl2:SanitizeChatLine(message)
    local chatLine = createChatLine(var6, tbl1.WHITE, not bool1)

    if arg1 then
        chatLine.User = arg1.Name
        chatLine.Origin = arg1.Character
    end

    if arg1 and chatLine.Origin then
        local fifo = tbl2.CharacterSortedMsg:Get(chatLine.Origin).Fifo
        fifo:PushBack(chatLine)

        tbl2:CreateChatLineRender(arg1.Character, chatLine, true, fifo, false)
    end
end

function tbl2:OnGameChatMessage(character: BasePart, message: string, chatColor: Enum.ChatColor)
    if var3 or var4 and Chat.BubbleChatEnabled then
        return
    end

    local localPlayer = Players.LocalPlayer
    local bool1 = not (localPlayer == nil) and localPlayer.Character ~= character
    local str1 = "dub"

    if chatColor == Enum.ChatColor.Blue then
        str1 = "blu"
    elseif chatColor == Enum.ChatColor.Green then
        str1 = "gre"
    elseif chatColor == Enum.ChatColor.Red then
        str1 = "red"
    end
    local gameChatLine = createGameChatLine(character, tbl2:SanitizeChatLine(message), not bool1, str1)

    tbl2.CharacterSortedMsg:Get(gameChatLine.Origin).Fifo:PushBack(gameChatLine)
    if var1 then
        tbl2:CreateChatLineRender(character, gameChatLine, false, tbl2.CharacterSortedMsg:Get(gameChatLine.Origin).Fifo, true)
        return
    end
    tbl2:CreateChatLineRender(character, gameChatLine, false, tbl2.CharacterSortedMsg:Get(gameChatLine.Origin).Fifo, false)
end

function tbl2:BubbleChatEnabled()
    if var3 or var4 and Chat.BubbleChatEnabled then
        return false
    end
    local clientChatModules = Chat:FindFirstChild("ClientChatModules")
    if clientChatModules then
        local chatSettings = clientChatModules:FindFirstChild("ChatSettings")
        if chatSettings then
            local var6 = require(chatSettings)
            if var6.BubbleChatEnabled ~= nil then
                return var6.BubbleChatEnabled
            end
        end
    end
    return Players.BubbleChat
end

function tbl2:ShowOwnFilteredMessage()
    local clientChatModules = Chat:FindFirstChild("ClientChatModules")
    if clientChatModules then
        local chatSettings = clientChatModules:FindFirstChild("ChatSettings")
        if chatSettings then
            return require(chatSettings).ShowUserOwnFilteredMessage
        end
    end
    return false
end

function findPlayer(name)
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name == name then
            return player
        end
    end
end

Chat.Chatted:connect(function(part: BasePart, message: string, color: Enum.ChatColor)
    tbl2:OnGameChatMessage(part, message, color)
end)
local connection = if game.Workspace.CurrentCamera then game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(function(_)
    tbl2:CameraCFrameChanged()
end) else nil

game.Workspace.Changed:Connect(function(property: string)
    if property ~= "CurrentCamera" then
        return
    end

    if connection then
        connection:disconnect()
    end

    if game.Workspace.CurrentCamera then
        connection = game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(function(_)
            tbl2:CameraCFrameChanged()
        end)
    end
end)

local var6 = nil

function getAllowedMessageTypes()
    if var6 then
        return var6
    end
    local clientChatModules = Chat:FindFirstChild("ClientChatModules")
    if not clientChatModules then
        return { "Message", "Whisper" }
    end

    local chatSettings = clientChatModules:FindFirstChild("ChatSettings")
    if chatSettings then
        local var7 = require(chatSettings)
        if var7.BubbleChatMessageTypes then
            var6 = var7.BubbleChatMessageTypes
            return var6
        end
    end
    local chatConstants = clientChatModules:FindFirstChild("ChatConstants")
    if chatConstants then
        local var7 = require(chatConstants)
        var6 = { var7.MessageTypeDefault, var7.MessageTypeWhisper }
    end
    return var6
end

function checkAllowedMessageType(arg1)
    local allowedMessageTypes = getAllowedMessageTypes()
    for i = 1, #allowedMessageTypes do
        if allowedMessageTypes[i] == arg1.MessageType then
            return true
        end
    end
    return false
end

local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local OnMessageDoneFiltering = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering")
DefaultChatSystemChatEvents:WaitForChild("OnNewMessage").OnClientEvent:connect(function(arg1, _)
    if not checkAllowedMessageType(arg1) then
        return
    end

    local player = findPlayer(arg1.FromSpeaker)
    if player
        and (arg1.IsFiltered and arg1.FromSpeaker ~= LocalPlayer.Name
            or arg1.FromSpeaker == LocalPlayer.Name and not tbl2:ShowOwnFilteredMessage())
    then
        tbl2:OnPlayerChatMessage(player, arg1.Message, nil)
    end
end)
OnMessageDoneFiltering.OnClientEvent:connect(function(arg1, _)
    if not checkAllowedMessageType(arg1) then
        return
    end

    local player = findPlayer(arg1.FromSpeaker)
    if player and (arg1.FromSpeaker ~= LocalPlayer.Name or tbl2:ShowOwnFilteredMessage()) then
        tbl2:OnPlayerChatMessage(player, arg1.Message, nil)
    end
end)
