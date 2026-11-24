-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)
local Foundation = require(ExpChatParent.Foundation)

local render = require(ExpChatParent.Dev.ReactTestingLibrary).render

local BenchmarkUtils = require(ExpChatParent.Dev.BenchmarkUtils)
local benchFile = BenchmarkUtils.benchFile
local benchmarkWarm = BenchmarkUtils.benchmarkWarm
local benchmarkInstanceCount = BenchmarkUtils.benchmarkInstanceCount

local Config = require(ExpChat.Config)

local Helpers = ExpChat.ChatWindow.Helpers
local getMessageSettings = require(Helpers.getMessageSettings)
local getMessageText = require(Helpers.getMessageText)

local TranslatedTextMessageV2 = require(ExpChat.ChatWindow.UI.TranslatedTextMessageV2)

local chatWindowSettings = {
    FontFace = Config.ChatWindowFont,
    TextColor3 = Config.ChatWindowTextColor3,
    TextSize = Config.ChatWindowTextSize,
    TextStrokeColor3 = Config.ChatWindowTextStrokeColor,
    TextStrokeTransparency = Config.ChatWindowTextStrokeTransparency,
    BackgroundColor3 = Config.ChatWindowBackgroundColor3,
    BackgroundTransparency = Config.ChatWindowBackgroundTransparency
}

local function createMessageElement(tbl2)
    local tbl3 = {
        text = "Sample text chat message text!",
        translation = "Exemple de texte de message de chat !",
        useTranslation = false,
        prefixText = "<font color=\"#FFA500\">PrefixText</font>",
        chatWindowMessageProperties = nil,
        isUserVerified = false,
        isSpatialUIEnabled = false,
        isTrustedConnection = false,
        wasRewritten = false,
        isRewriteWindowOpen = false
    }

    if tbl2 then
        for value, value2 in tbl2 do
            tbl3[value] = value2
        end
    end

    local message = {
        current = {
            text = tbl3.text,
            translation = tbl3.translation,
            useTranslation = tbl3.useTranslation,
            prefixText = tbl3.prefixText,
            userId = 0,
            messageId = "0",
            chatWindowMessageProperties = tbl3.chatWindowMessageProperties
        }
    }
    local messageSettings = getMessageSettings(message.current, chatWindowSettings)

    return React.createElement(TranslatedTextMessageV2, {
        chatWindowSettings = chatWindowSettings,
        textTransparency = React.createBinding(0),
        onTextMessageLabelButtonActivated = function() end,
        isSpatialUIEnabled = tbl3.isSpatialUIEnabled,
        originalBodyText = React.createBinding(getMessageText(message.current.useTranslation, messageSettings.translation, messageSettings.text)),
        originalPrefixText = React.createBinding(messageSettings.prefixText or ""),
        shouldShowTranslationToggle = React.createBinding(false),
        bodyTextProperties = React.createBinding(messageSettings.bodyTextProperties),
        prefixTextProperties = React.createBinding(messageSettings.prefixTextProperties),
        layoutOrder = React.createBinding(0),
        visible = React.createBinding(true),
        isUserVerified = React.createBinding(tbl3.isUserVerified),
        message = message,
        isTrustedConnection = React.createBinding(tbl3.isTrustedConnection),
        wasRewritten = React.createBinding(tbl3.wasRewritten),
        isRewriteWindowOpen = React.createBinding(tbl3.isRewriteWindowOpen),
        chatWindowTransparencyBindable = React.createBinding(0),
        arButtonPadding = React.createBinding(UDim.new(0, 0))
    })
end

local function messageList(tbl2)
    local tbl3 = ({})
    for i = 1, 50 do
        tbl3[i] = createMessageElement(tbl2)
    end
    return React.createElement(
        Foundation.FoundationProvider,
        { device = "Desktop", colorMode = "Dark" },
        {
            List = React.createElement("Frame", { Size = UDim2.fromScale(1, 1) }, tbl3)
        }
    )
end
local var1 = messageList()
local var2 = messageList({ useTranslation = true })
local var3 = messageList({ isUserVerified = true })

benchFile(script, function()
    benchmarkWarm(`Render {50} TranslatedTextMessages`, function()
        render(var1):unmount()
    end)

    benchmarkWarm(`Render {50} TranslatedTextMessages with translation`, function()
        render(var2):unmount()
    end)

    benchmarkWarm(`Render {50} TranslatedTextMessages (verified user)`, function()
        render(var3):unmount()
    end)

    benchmarkInstanceCount(`Mount {50} TranslatedTextMessages`, var1)
end)
