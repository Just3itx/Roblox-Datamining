-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local Foundation = require(SduiSharedContentParent.Foundation)
local React = require(SduiSharedContentParent.React)

local IconName = Foundation.Enums.IconName
local List = Foundation.List

return React.memo(function(tbl1) -- name: SduiListItem
    local leading = React.useMemo(function()
        if tbl1.leadingIcon then
            return IconName[tbl1.leadingIcon] or {
                iconName = tbl1.leadingIcon
            }
        end

        return nil
    end, { tbl1.leadingIcon })

    local title = React.useMemo(function()
        if tbl1.titleMetadata then
            return {
                title = tbl1.title or "",
                metadata = tbl1.titleMetadata
            }
        end

        return tbl1.title or ""
    end, { tbl1.title, tbl1.titleMetadata })

    local input = React.useMemo(function()
        local input = tbl1.input
        if typeof(input) ~= "table" then
            return input
        end
        local onActivated = input.onActivated
        if typeof(onActivated) ~= "function" then
            return input
        end

        local var3 = table.clone(input)
        function var3.onActivated(isChecked: boolean)
            onActivated(nil, nil, { isChecked = isChecked })
        end
        return var3
    end, { tbl1.input })

    return React.createElement(List.Item, {
        leading = leading,
        title = title,
        description = tbl1.description,
        trailing = tbl1.trailing,
        onActivated = tbl1.onActivated,
        input = input,
        LayoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    })
end)
