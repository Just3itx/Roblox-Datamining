-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local str1 = game:DefineFastString(
    "BuildAgentRollbackVersionPrompt",
    "<system_reminder>The user reverted the game to version {versionNumber}. Call restore_version."
)

local str2 = game:DefineFastString("BuildAgentRollbackNotePrompt", " Add note title {title} and description {description}")

local function fill(str3: string, tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (str3:gsub("{(%w+)}", function(arg1): string
        return tostring(tbl1[arg1])
    end))
end

local function buildAgentRollbackPrompt(versionNumber: number, title: string?, description: string?)
    return fill(str1, { versionNumber = versionNumber }) .. (if title == nil or title == "" or description == nil or description == "" then "" else fill(str2, { title = title, description = description })) .. "</system_reminder>"
end

return buildAgentRollbackPrompt
