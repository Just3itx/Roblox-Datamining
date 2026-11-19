-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(CorePackages.Packages.React)
local UIBlox = require(CorePackages.Packages.UIBlox)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)

local useLayoutValues = PlayerList.Common.useLayoutValues
local useStyle = UIBlox.Core.Style.useStyle

local PlayerEntryContainer = require(scriptParentParentParent.Components.Container.PlayerEntryContainer)
local TeamEntryContainer = require(scriptParentParentParent.Components.Container.TeamEntryContainer)

local FFlagReplacePlayerIconRoduxWithSignal = require(CorePackages.Workspace.Packages.SharedFlags).FFlagReplacePlayerIconRoduxWithSignal
local FFlagPlayerListUseFocusNavHook = PlayerList.Flags.FFlagPlayerListUseFocusNavHook

local PlayerIconInfoStore = require(CorePackages.Workspace.Packages.PlayerIconInfoStore).PlayerIconInfoStore

return React.memo(function(tbl1) -- name: TeamListView
    local var1 = useLayoutValues()
    local var2 = useStyle()

    local tbl2 = {}

    local createElement = React.createElement
    local str1 = "UIListLayout"
    local tbl3 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        Padding = if tbl1.isDirectionalPreferred then UDim.new(0, var1.EntryPadding) else nil
    }
    tbl2.UIListLayout = createElement(str1, tbl3)

    if tbl1.showTeamEntry then
        tbl2.TeamEntry = React.createElement(TeamEntryContainer, {
            size = UDim2.new(1, 0, 0, var1.TeamEntrySizeY),
            teamData = tbl1.teamData,
            entrySizeX = tbl1.entrySizeX,
            isSmallTouchDevice = tbl1.isSmallTouchDevice,
            isDirectionalPreferred = tbl1.isDirectionalPreferred,
            layoutOrder = -1
        })
    end

    if tbl1.teamPlayersCount > 0 then
        local num1 = 0

        if tbl1.isSmallTouchDevice then
            tbl2.BottomDiv = React.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 0, 0),
                AnchorPoint = Vector2.new(0, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.8,
                LayoutOrder = tbl1.teamPlayersCount * 2
            })
        end

        tbl1.teamData.players.iterateData(function(player, arg1)
            num1 += 1
            local playerIconInfo = if FFlagReplacePlayerIconRoduxWithSignal then PlayerIconInfoStore.getPlayerIconInfoReactive(player.UserId)(false) else tbl1.playerIconInfos[arg1]
            local playerRelationship = tbl1.playerRelationships[arg1]

            if not (playerIconInfo and playerRelationship) then
                return
            end

            local tbl4 = tbl2
            local str2 = "PlayerEntry_" .. tostring(arg1)
            tbl4[str2] = React.createElement(PlayerEntryContainer, {
                size = UDim2.new(1, var1.EntryXOffset, 0, var1.PlayerEntrySizeY),
                player = player,
                titlePlayerEntry = false,
                entrySizeX = tbl1.entrySizeX,
                playerIconInfo = playerIconInfo,
                playerRelationship = playerRelationship,
                setDropDownPlayerDimensionY = tbl1.setDropDownPlayerDimensionY,
                firstPlayerRef = tbl1.firstPlayerRef,
                prevFocusedEntry = tbl1.prevFocusedEntry,
                destroyedFocusedPlayerId = tbl1.destroyedFocusedPlayerId,
                registerPlayerInstance = if FFlagPlayerListUseFocusNavHook then tbl1.registerPlayerInstance else nil,
                unregisterPlayerInstance = if FFlagPlayerListUseFocusNavHook then tbl1.unregisterPlayerInstance else nil,
                setSelectedPlayerId = if FFlagPlayerListUseFocusNavHook then tbl1.setSelectedPlayerId else nil
            })

            if tbl1.isSmallTouchDevice then
                tbl2["TopDiv_" .. num1] = React.createElement("Frame", {
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 0, 0),
                    AnchorPoint = Vector2.new(0, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 0.8,
                    LayoutOrder = (num1 - 1) * 2
                })
            end

            if not (num1 < tbl1.teamPlayersCount) or tbl1.isSmallTouchDevice or tbl1.isDirectionalPreferred then
                return
            end

            tbl2["Divider_" .. num1] = React.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, 0),
                AnchorPoint = Vector2.new(0, 1),
                BackgroundTransparency = var2.Theme.Divider.Transparency,
                BackgroundColor3 = var2.Theme.Divider.Color,
                BorderSizePixel = 0,
                LayoutOrder = num1 * 2
            })
        end, false)
    end

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder
    }, tbl2)
end)
