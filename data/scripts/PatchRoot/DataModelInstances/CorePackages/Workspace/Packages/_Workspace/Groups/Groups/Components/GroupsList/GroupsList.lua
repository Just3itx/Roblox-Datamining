-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)
local useLocalization = require(GroupsParent.Localization).Hooks.useLocalization

local ScrollView = Foundation.ScrollView
local View = Foundation.View
local FoundationText = Foundation.Text
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility

local TextKeys = require(Groups.Common.TextKeys)
local _Types = require(Groups.Common.Types)
local GroupsListToolbar = require(script.Parent.GroupsListToolbar)
local GroupsListSection = require(script.Parent.GroupsListSection)
local GroupsListHeader = require(script.Parent.GroupsListHeader)
local GroupListItemSkeleton = require(script.Parent.GroupListItemSkeleton)

local var1 = table.freeze({})

local function renderSkeletons()
    local result = {}
    for layoutOrder = 1, 3 do
        result[`Skeleton_{layoutOrder}`] = React.createElement(GroupListItemSkeleton, { layoutOrder = layoutOrder })
    end

    return result
end

local function GroupsList(tbl1)
    local var2 = useLocalization({
        primaryHeading = TextKeys.HeadingPrimary,
        myGroupsHeading = TextKeys.HeadingMyGroups,
        loadFailure = TextKeys.MessageLoadGroupListError,
        notInGroups = TextKeys.MessageNotInAnyGroups,
        noResults = TextKeys.MessageNoGroupsFound
    })

    local var3 = tbl1.groupsList or var1
    local var4, onSearchTextChanged = React.useState("")
    local scrollingFrameRef = React.useRef(nil)

    local var7 = React.useMemo(function()
        for _, value in ipairs(var3) do
            if value.isPrimary then
                return value
            end
        end
        return nil
    end, { var3 })

    local groups = React.useMemo(function()
        if not var7 then
            return var3
        end

        local result = {}
        for _, value in ipairs(var3) do
            if value ~= var7 then
                table.insert(result, value)
            end
        end
        return result
    end, { var3, var7 })

    local var5 = React.useMemo(function(): {[any]: any} | {any}
        return if var7 then { var7 } else {}
    end, { var7 })

    React.useEffect(function()
        if var4 ~= "" and scrollingFrameRef.current then
            scrollingFrameRef.current.CanvasPosition = Vector2.new(0, 0)
        end
    end, { var4 })

    local bool1 = var4 ~= ""

    local var10 = React.useMemo(function()
        if not bool1 then
            return nil
        end
        local str1 = string.lower(var4)
        local result = {}
        for _, value in ipairs(var3) do
            local str2 = string.lower(value.name or "")
            if string.find(str2, str1, 1, true) then
                result[value.id] = true
            end
        end
        return result
    end, { var3, var4 })

    local bool2 = bool1 and not (var10 == nil) and next(var10) == nil

    local var11 = React.useMemo(function()
        if tbl1.isLoading or not tbl1.groupsList then
            return nil
        end

        if tbl1.loadFailure then
            return var2.loadFailure
        end

        if #var3 == 0 then
            return var2.notInGroups
        end

        if bool2 then
            return var2.noResults
        end

        return nil
    end, {
        tbl1.isLoading,
        tbl1.groupsList,
        tbl1.loadFailure,
        var2,
        var3,
        bool2
    })
    local var12 = tbl1.isLoading and #var3 == 0

    local bool3 = #var5 > 0 or #groups > 0
    local element

    if var12 then
        element = React.createElement(
            View,
            {
                tag = "col padding-small gap-small",
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            },
            (renderSkeletons())
        )
    elseif bool3 then
        local createElement = React.createElement
        local var13 = ScrollView
        local tbl2 = {
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.new(1, 0, 0, 0),
                ScrollingDirection = Enum.ScrollingDirection.Y,
                scrollBarVisibility = ScrollBarVisibility.Auto,
                VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
            },
            scrollingFrameRef = scrollingFrameRef,
            Size = UDim2.new(1, 0, 1, 0)
        }
        local tbl3 = { ListWrapper = 0 }
        local createElement2 = React.createElement
        local var14 = View
        local tbl4 = {
            tag = "col gap-xlarge",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        }
        local tbl5 = {
            PrimarySection = React.createElement(GroupsListSection, {
                layoutOrder = 1,
                heading = var2.primaryHeading,
                groups = var5,
                showRank = true,
                showMemberCount = true,
                visibleIds = if bool1 then var10 else nil
            }),
            OtherGroupsSection = 0
        }
        local createElement3 = React.createElement
        local var15 = GroupsListSection
        local tbl6 = {
            layoutOrder = 2,
            heading = if #var5 > 0 then var2.myGroupsHeading else nil,
            groups = groups,
            showRank = true,
            showMemberCount = true,
            visibleIds = 0
        }

        if not bool1 then
            var10 = nil
        end

        tbl6.visibleIds = var10
        tbl5.OtherGroupsSection = createElement3(var15, tbl6)
        tbl3.ListWrapper = createElement2(var14, tbl4, tbl5)
        element = createElement(var13, tbl2, tbl3)
    else
        element = nil
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col gap-xlarge",
            Size = UDim2.new(1, 0, 1, 0)
        },
        {
            Header = React.createElement(GroupsListHeader, { layoutOrder = 1 }),
            Toolbar = React.createElement(
                GroupsListToolbar,
                {
                    layoutOrder = 2,
                    canCreateGroup = tbl1.canCreateGroup,
                    onSearchTextChanged = onSearchTextChanged
                }
            ),
            Disclaimer = var11
                and React.createElement(
                    FoundationText,
                    {
                        LayoutOrder = 3,
                        Text = var11,
                        tag = "content-muted text-align-x-left text-body-medium"
                    }
                )
                or nil,
            List = element
                and React.createElement(View, { LayoutOrder = 4, tag = "fill", Size = UDim2.new(1, 0, 1, 0) }, { ListContent = element })
                or nil
        }
    )
end

return GroupsList
