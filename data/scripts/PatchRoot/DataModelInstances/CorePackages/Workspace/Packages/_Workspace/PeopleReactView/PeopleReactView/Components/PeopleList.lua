-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local Foundation = require(PeopleReactViewParent.Foundation)
local React = require(PeopleReactViewParent.React)
local PeopleService = require(PeopleReactViewParent.PeopleService)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local View = Foundation.View
local useSignalState = SignalsReact.useSignalState

local PersonRow = require(PeopleReactView.Components.List.PersonRow)
local LazyPersonRow = require(PeopleReactView.Components.List.LazyPersonRow)

local _GetScrollingFrameStore = require(PeopleReactView.Stores.GetScrollingFrameStore)

local service = PeopleService.getService("Flags")
local GetFFlagAddPeoplePageCardLayout = service.GetFFlagAddPeoplePageCardLayout
local FFlagEnablePeopleListLazyRender = service.FFlagEnablePeopleListLazyRender

local function MemoizedPersonRow(tbl1)
    return React.useMemo(function()
        if not FFlagEnablePeopleListLazyRender then
            return (React.createElement(PersonRow, { key = tostring(tbl1.person.UserId), person = tbl1.person, layoutOrder = tbl1.index }))
        end

        return (React.createElement(LazyPersonRow, {
            key = tostring(tbl1.person.UserId),
            person = tbl1.person,
            layoutOrder = tbl1.index,
            scrollingFrameStore = tbl1.scrollingFrameStore
        }))
    end, { tbl1.person.UserId, tbl1.index, tbl1.scrollingFrameStore })
end

local function buildPersonRows(tbl1, tbl2, tbl3, scrollingFrameStore)
    local tbl4 = ({})
    local tbl5 = {}
    local num1 = 0

    if not next(tbl3) then
        for value, value2 in tbl1 do
            local userId = value2.UserId
            tbl3[userId] = (value - 1) * math.floor(100000 / #tbl1)
        end
    end

    for value, person in tbl1 do
        if tbl2[person.UserId] then
            tbl4[person.UserId] = tbl2[person.UserId]
            tbl5[person.UserId] = tbl3[person.UserId]
            num1 = tbl3[person.UserId]
        else
            if value == 1 then
                num1 = 0
            else
                local var1 = value + 1
                local num2 = 100000

                while var1 <= #tbl1 do
                    local userId = tbl1[var1].UserId
                    if tbl3[userId] then
                        num2 = tbl3[userId]
                        break
                    end

                    var1 += 1
                end

                num1 = math.floor((num1 + num2) / 2)
            end

            local userId = person.UserId
            tbl4[userId] = React.createElement(MemoizedPersonRow, {
                person = person,
                index = num1,
                scrollingFrameStore = if FFlagEnablePeopleListLazyRender then scrollingFrameStore else nil
            })
            tbl5[person.UserId] = num1
        end
    end

    return tbl4, tbl5
end

local function PeopleList(tbl1)
    local var1 = React.useMemo(function()
        return PeopleService.getService("PeopleListStore")
    end, {})

    local var2 = useSignalState(var1.people)
    local ref = React.useRef(nil)

    local var4 = React.useRef({})
    local var5 = React.useRef({})

    local func1 = buildPersonRows

    local current = var4.current
    local current2 = var5.current
    local scrollingFrameStore = if FFlagEnablePeopleListLazyRender then tbl1.scrollingFrameStore else nil
    local tbl2, tbl3 = func1(var2, current, current2, scrollingFrameStore)
    var4.current = tbl2
    var5.current = tbl3

    local current3 = var4.current

    return React.createElement(
        View,
        {
            tag = "size-full-0 auto-y col gap-small",
            LayoutOrder = if GetFFlagAddPeoplePageCardLayout() then tbl1.LayoutOrder else 2
        },
        {
            PeopleList = React.createElement(View, { tag = "size-full-0 col gap-small auto-y", ref = ref }, { current3 })
        }
    )
end

if service.FFlagPeoplePageRemoveUseMemoElements then
    return React.memo(PeopleList)
end
return PeopleList
