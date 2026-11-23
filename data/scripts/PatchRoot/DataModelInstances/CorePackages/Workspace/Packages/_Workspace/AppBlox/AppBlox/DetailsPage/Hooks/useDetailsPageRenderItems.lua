-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent

local React = require(AppBloxParent.React)
local _Types = require(script.Parent.Parent.Types)

local function useDetailsPageRenderItems(arg1, headerContainer, vector2: Vector2, vector2_2: Vector2)
    local var1 = React.useMemo(function()
        local result = {}
        for key, value2 in arg1 do
            table.insert(result, {
                index = value2.portraitLayoutOrder + 1,
                renderComponent = value2.renderComponent,
                showCornerGradient = value2.showCornerGradient,
                useSelectionBumper = value2.useSelectionBumper,
                key = key
            })
        end

        table.sort(result, function(arg3, arg4): boolean
            return not arg4.index or (if arg3.index then arg3.index <= arg4.index else false)
        end)

        return result
    end, { arg1 })

    return (React.useMemo(function()
        local var2 = table.clone(var1)

        table.insert(var2, 1, {
            index = 1,
            key = "Header",
            showCornerGradient = true,
            renderComponent = function()
                return React.createElement(
                    "Frame",
                    {
                        Size = UDim2.new(1, 0, 0, vector2.Y - vector2_2.Y * 2),
                        BackgroundTransparency = 1
                    },
                    {
                        Layout = React.createElement("UIListLayout", { VerticalAlignment = Enum.VerticalAlignment.Bottom }),
                        HeaderContainer = headerContainer
                    }
                )
            end
        })

        return var2
    end, {
        var1,
        headerContainer,
        vector2.Y,
        vector2_2.Y
    }))
end
return useDetailsPageRenderItems
