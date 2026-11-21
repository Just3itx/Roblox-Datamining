-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _AXPagesTypes = require(script.Parent.AXPagesTypes)

return {
    new = function(_currentPage, _cursor: string?, _fetchNextPage: (...any) -> (...any))
        return {
            _currentPage = _currentPage,
            _cursor = _cursor,
            _fetchNextPage = _fetchNextPage,
            IsFinished = _cursor == nil or _cursor == "",
            GetCurrentPage = function(arg1)
                return arg1._currentPage
            end,
            AdvanceToNextPageAsync = function(arg1)
                if arg1.IsFinished then
                    return
                end

                local var1 = arg1._fetchNextPage(arg1._cursor)
                arg1._currentPage = var1.data
                arg1._cursor = var1.nextPageCursor
                arg1.IsFinished = arg1._cursor == nil or arg1._cursor == ""
            end
        }
    end
}
