-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local Foundation = require(OnPlatformSurveysParent.Foundation)
local React = require(OnPlatformSurveysParent.React)

local Icon = Foundation.Icon
local IconVariant = Foundation.Enums.IconVariant
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local _InlineSurveyTypes = require(OnPlatformSurveys.Types.InlineSurveyTypes)

local tbl1 = {}

local tbl2 = {
    { id = "1", icon = "thumb-down" },
    { id = "2", icon = "thumb-up" }
}

local function findChoice(question, id: string) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in question.choices or tbl1 do
        if value.id == id then
            return value
        end
    end
    return nil
end

return React.memo(function(tbl3) -- name: ThumbsQuestion
    local var1 = useTokens()
    local question = tbl3.question
    local answer = tbl3.answer
    local bool1 = tbl3.isDisabled == true
    local choiceId = if answer.choiceIds == nil then nil else answer.choiceIds[1]
    local var2, var3 = React.useState(nil)

    local color3 = var1.Color.Content.Default.Color3

    local tbl4 = ({})
    for layoutOrder, value2 in tbl2 do
        local choice = findChoice(question, value2.id)
        if choice == nil then
            continue
        end

        local bool2 = choiceId == value2.id
        local bool3 = var2 == value2.id

        local var4 = "Cell_" .. value2.id
        local createElement = React.createElement
        local var5 = View
        local tbl5 = { tag = "col align-x-center gap-small auto-xy", LayoutOrder = layoutOrder }
        local tbl6 = { Button = 0, Label = 0 }
        local createElement2 = React.createElement
        local str1 = "TextButton"
        local tbl7 = {
            Size = nil,
            Size = UDim2.fromOffset(76, 76),
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false,
            Active = not bool1,
            Selectable = not bool1,
            LayoutOrder = 1,
            [React.Tag] = "data-testid=thumb-" .. value2.id
        }

        tbl7[React.Event.Activated] = function()
            if bool1 then
                return
            end

            tbl3.onAnswerChanged({ choiceIds = bool2 and {} or { value2.id } })
        end

        tbl7[React.Event.MouseEnter] = function()
            var3(value2.id)
        end
        tbl7[React.Event.MouseLeave] = function()
            var3(function(id: string?): string?
                return if id == value2.id then nil else id
            end)
        end

        local tbl8 = {
            Backplate = React.createElement(View, {
                tag = "size-full radius-circle",
                backgroundStyle = {
                    Color3 = color3,
                    Transparency = if bool2 then 0.75 elseif bool3 then 0.85 else 0.92
                },
                ZIndex = 1
            }),
            Icon = React.createElement(Icon, {
                name = value2.icon,
                size = 40,
                variant = if bool2 then IconVariant.Filled else IconVariant.Regular,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                ZIndex = 2
            })
        }
        tbl6.Button = createElement2(str1, tbl7, tbl8)

        tbl6.Label = React.createElement(
            FoundationText,
            {
                Text = choice.label,
                tag = "auto-xy text-body-medium text-align-x-center content-default",
                LayoutOrder = 2
            }
        )
        tbl4[var4] = createElement(var5, tbl5, tbl6)
    end

    return React.createElement(
        View,
        {
            tag = "row flex-around align-y-top size-full-0 auto-y",
            LayoutOrder = tbl3.layoutOrder
        },
        tbl4
    )
end)
