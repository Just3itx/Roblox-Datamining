-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local Roact = require(SocialLibraries.dependencies).Roact

local var1 = Roact.PureComponent:extend("SortedList")
var1.defaultProps = {
    entries = {},
    renderEntry = nil,
    entryHeight = 48,
    sortComparator = function(_, _): boolean
        return true
    end,
    LayoutOrder = 0
}

function var1.sortEntries(arg1)
    local result = {}

    for _, value in pairs(arg1.props.entries) do
        table.insert(result, value)
    end

    table.sort(result, arg1.props.sortComparator)

    return result
end

function var1.render(arg1)
    local var2 = arg1:sortEntries()

    local tbl1 = {
        layout = Roact.createElement(
            "UIListLayout",
            {
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        )
    }

    for layoutOrder, value in pairs(var2) do
        local bool1 = layoutOrder == #var2

        table.insert(
            tbl1,
            Roact.createElement(
                "Frame",
                {
                    Size = UDim2.new(1, 0, 0, arg1.props.entryHeight),
                    BackgroundTransparency = 1,
                    LayoutOrder = layoutOrder
                },
                {
                    entry = arg1.props.renderEntry(value, bool1)
                }
            )
        )
    end

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, #arg1.props.entries * arg1.props.entryHeight),
        BackgroundTransparency = 1,
        LayoutOrder = arg1.props.LayoutOrder
    }, tbl1)
end

return var1
