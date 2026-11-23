-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local Regex = require(script.Parent.Regex)

local PATH_CHAR = Regex.oneOf({ Regex.set("\\w\\-\\.\\_\\~\\!\\$\\&\\'\\*\\+\\,\\;\\=\\(\\)\\:\\@"), "\\%[A-Fa-f0-9]{2}" })
local QUERY_CHAR = Regex.oneOf({ Regex.set("\\w\\-\\.\\_\\~\\!\\$\\&\\'\\*\\+\\,\\;\\=\\(\\)\\:\\@\\/\\?"), "\\%[A-Fa-f0-9]{2}" })
local FRAGMENT_CHAR = Regex.oneOf({ Regex.set("\\w\\-\\.\\_\\~\\!\\$\\&\\'\\*\\+\\,\\;\\=\\(\\)\\:\\@\\/\\?\\#"), "\\%[A-Fa-f0-9]{2}" })

local COMMON_TLD_PATTERNS = {
    "com",
    "net",
    "org",
    "[a-z]{2}"
}

local var4 = "\\w(?:[\\w\\-]{0,61}\\w)?" .. Regex.DOT .. Regex.zeroOrMore(Regex.oneOf(COMMON_TLD_PATTERNS) .. Regex.DOT) .. Regex.oneOf(COMMON_TLD_PATTERNS)
return {
    PATH_CHAR = PATH_CHAR,
    QUERY_CHAR = QUERY_CHAR,
    FRAGMENT_CHAR = FRAGMENT_CHAR,
    ANY_DOMAIN_NAME = "\\w(?:[\\w\\-]{0,61}\\w)?",
    ANY_HOSTNAME_PATTERN = var4,
    HTTP_PROTOCOL_PATTERNS = { "https", "http" },
    COMMON_TLD_PATTERNS = COMMON_TLD_PATTERNS,
    ANY_DOMAIN_PATTERN = var4
}
