-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")
local ReactionsParent = Reactions.Parent

local Foundation = require(ReactionsParent.Foundation)
local FoundationImages = require(ReactionsParent.FoundationImages)
local React = require(ReactionsParent.React)

local Constants = require(Reactions.Constants)
local ReactRoblox = require(ReactionsParent.Dev.ReactRoblox)
local ReactTestingLibrary = require(ReactionsParent.Dev.ReactTestingLibrary)
local Rhodium = require(ReactionsParent.Dev.Rhodium)

local FoundationProvider = Foundation.FoundationProvider

local module = {}

function module.withFoundation(tbl1, overlayGui, preferences)
    return React.createElement(
        FoundationProvider,
        {
            theme = Foundation.Enums.Theme.Dark,
            overlayGui = overlayGui,
            preferences = preferences
        },
        tbl1
    )
end

function module.render(subject, container, preferences)
    local var1 = nil
    ReactRoblox.act(function()
        var1 = ReactTestingLibrary.render(
            module.withFoundation({ Subject = subject }, container, preferences),
            container and { container = container } or nil
        )
    end)
    return var1
end

local function TokenProbe(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    tbl1.onTokens(var1)
    return nil
end

function module.getTokens()
    local var1 = nil
    module.runWhileMounted(module.withFoundation({
        Probe = React.createElement(TokenProbe, {
            onTokens = function(arg1)
                var1 = arg1
            end
        })
    }), function() end)

    assert(var1 ~= nil, "expected FoundationProvider to provide tokens")
    return var1
end

function module.createOverlayGui(): ScreenGui
    local testOverlay = Instance.new("ScreenGui")
    testOverlay.Name = "TestOverlay"
    testOverlay.Parent = game:GetService("CoreGui")
    return testOverlay
end

function module.getExpectedReactionSprite(str1: string)
    local reactionIconMapping = Constants.ReactionIconMappings[str1]
    local var1 = FoundationImages.Images[reactionIconMapping]
    return {
        Image = var1.Image,
        ImageRectOffset = var1.ImageRectOffset
    }
end

function module.getReactionSprite(arg1)
    return {
        Image = arg1.Image,
        ImageRectOffset = arg1.ImageRectOffset
    }
end

function module.runWhileMounted(arg1, callback: (...any) -> (...any))
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game:GetService("CoreGui")

    local root = ReactRoblox.createRoot(screenGui)

    ReactRoblox.act(function()
        root:render(arg1)
    end)

    local success, result = pcall(callback, screenGui)

    root:unmount()
    screenGui:Destroy()

    if not success then
        error(result)
    end
end

function module.findFirstInstance(arg1, tbl1)
    for _, descendant in arg1:GetDescendants() do
        local bool1 = true
        for value, value2 in tbl1 do
            local success, result = pcall(function()
                return descendant[value]
            end)
            if not success or result ~= value2 then
                bool1 = false
                break
            end
        end

        if bool1 then
            return descendant
        end
    end
    return nil
end

function module.countChildren(arg1, str1: string, func1: ((...any) -> (...any))?)
    local firstInstance = module.findFirstInstance(arg1, { Name = str1 })
    if not firstInstance then
        return 0
    end
    local num1 = 0
    for _, child in firstInstance:GetChildren() do
        if func1 == nil or func1(child) then
            num1 += 1
        end
    end
    return num1
end

function module.clickInstance(arg1)
    Rhodium.Element.new(arg1):click()
    task.wait()
end

return module
