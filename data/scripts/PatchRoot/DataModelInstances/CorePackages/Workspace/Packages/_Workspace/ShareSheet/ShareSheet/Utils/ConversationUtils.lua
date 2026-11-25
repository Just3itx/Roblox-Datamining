-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    getDisplayName = function(tbl1)
        local titleForViewer = tbl1.titleForViewer
        return if titleForViewer and titleForViewer ~= "" then titleForViewer else tbl1.title or ""
    end
}
