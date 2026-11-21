-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent
local useLocalization = require(FriendsLandingParent.Localization).Hooks.useLocalization
local dependencyArray = require(FriendsLandingParent.RoactUtils).Hooks.dependencyArray

local React = require(FriendsLandingParent.React)
local Chip = require(FriendsLandingParent.Foundation).Chip
local filterStates = require(FriendsLanding.Friends.filterStates)
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)
local FFlagDisableFriendsLandingFilterChipsWithNoFriends = require(FriendsLanding.Flags.FFlagDisableFriendsLandingFilterChipsWithNoFriends)

local tbl1 = { filterStates.All, filterStates.Online, filterStates.Trusted }

local tbl2 = {
    [filterStates.All] = "all",
    [filterStates.Online] = "online",
    [filterStates.Trusted] = "trusted"
}

local tbl3 = { "allFriendsChip", "onlineFriendsChip", "trustedFriendsChip" }

function ChipFilterGroup(tbl4)
    local filter = React.useContext(FriendsLandingContext.Context).filter
    local var1 = useLocalization({
        all = "Feature.Friends.Label.All",
        online = "Common.Presence.Label.Online",
        trusted = "Feature.Friends.TrustedConnection.Label.Trusted"
    })

    local useMemo = React.useMemo

    local function func1()
        local result = ({})
        for layoutOrder, id in ipairs(tbl1) do
            local var2 = tbl3[layoutOrder]
            local createElement = React.createElement
            local var3 = Chip
            local tbl5 = {
                id = id,
                text = var1[tbl2[id]],
                LayoutOrder = layoutOrder,
                onActivated = 0,
                isChecked = 0,
                isDisabled = 0
            }

            function tbl5.onActivated()
                tbl4.onActivated(id)
            end
            tbl5.isChecked = filter == id
            tbl5.isDisabled = if FFlagDisableFriendsLandingFilterChipsWithNoFriends then tbl4.isDisabled else nil
            result[var2] = createElement(var3, tbl5)
        end

        return result
    end

    local var2 = dependencyArray
    local onActivated = tbl4.onActivated
    local isDisabled = if FFlagDisableFriendsLandingFilterChipsWithNoFriends then tbl4.isDisabled else nil
    local var3 = useMemo(func1, var2(var1, filter, onActivated, isDisabled))

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 32),
            LayoutOrder = tbl4.layoutOrder,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            }),
            allFriendsChip = var3.allFriendsChip,
            onlineFriendsChip = var3.onlineFriendsChip,
            trustedFriendsChip = var3.trustedFriendsChip
        }
    )
end
return ChipFilterGroup
