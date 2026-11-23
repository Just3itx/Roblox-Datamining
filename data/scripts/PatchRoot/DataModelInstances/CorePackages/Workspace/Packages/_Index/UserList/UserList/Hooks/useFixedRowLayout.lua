-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserList = script:FindFirstAncestor("UserList")
local UserListParent = UserList.Parent

local React = require(UserListParent.React)
local Foundation = require(UserListParent.Foundation)
local Constants = require(UserList.Common.Constants)

local function useFixedRowLayout(bool1: boolean, bool2: boolean)
    local var1 = Foundation.Hooks.useTokens()

    local length = Constants.USER_ROW_HEIGHT + 2 * var1.Padding.Medium
    local var2, var3 = React.useState(0)

    local onHeaderSizeChanged = React.useCallback(function(arg1)
        var3(arg1.AbsoluteSize.Y)
    end, {})

    local var5 = if bool2 then var2 else 0

    return React.useMemo(function(): {getItemLayout: ({[any]: any}?, number) -> {index: number, length: any, offset: any}, itemSize: UDim2, onHeaderSizeChanged: any}?
        return if bool1 then {
            itemSize = UDim2.new(1, 0, 0, length),
            getItemLayout = function(_, index: number)
                return {
                    length = length,
                    offset = var5 + length * (index - 1),
                    index = index
                }
            end,
            onHeaderSizeChanged = onHeaderSizeChanged
        } else nil
    end, {
        bool1,
        length,
        var5,
        onHeaderSizeChanged
    })
end
return useFixedRowLayout
