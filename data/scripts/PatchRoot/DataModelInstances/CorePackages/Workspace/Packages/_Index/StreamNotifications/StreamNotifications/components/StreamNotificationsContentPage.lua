-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local StreamNotificationsParent = StreamNotifications.Parent

local React = require(StreamNotificationsParent.React)
local SignalsReact = require(StreamNotificationsParent.SignalsReact)
local SduiSharedUtilities = require(StreamNotificationsParent.SduiSharedUtilities)

local ContentPageConstants = require(StreamNotifications.ContentPage.ContentPageConstants)

local SduiFeatureEntryPoint = SduiSharedUtilities.SduiFeatureEntryPoint
local getSduiApiStore = SduiSharedUtilities.getSduiApiStore
local usePageScopeRef = SduiSharedUtilities.usePageScopeRef

local ConfigKey = ContentPageConstants.ConfigKey

local function StreamNotificationsContentPage(tbl1)
    usePageScopeRef(ConfigKey)
    local var1 = SignalsReact.useSignalState(getSduiApiStore().getData(ConfigKey).data)

    local tbl2 = {}
    if var1 then
        for _, value in var1 do
            if value.identifier
                and value.identifier ~= ""
                and value.identifier ~= ContentPageConstants.FeedEntryIdentifier
                and value.config
            then
                table.insert(tbl2, value)
            end
        end
    end
    table.sort(tbl2, function(arg1, arg2): boolean
        return arg1.identifier < arg2.identifier
    end)

    local tbl3 = {}
    for layoutOrder, value2 in tbl2 do
        local identifier = value2.identifier
        tbl3[identifier] = React.createElement(SduiFeatureEntryPoint, {
            configKey = ConfigKey,
            identifier = value2.identifier,
            appPage = ConfigKey,
            shouldDisplayLoading = false,
            shouldDisplayError = false,
            LayoutOrder = layoutOrder
        })
    end
    if not (#tbl2 > 0) then
        return nil
    end

    tbl3.UIListLayout = React.createElement(
        "UIListLayout",
        {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder
        }
    )
    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.LayoutOrder,
        Position = tbl1.Position
    }, tbl3)
end

return StreamNotificationsContentPage
