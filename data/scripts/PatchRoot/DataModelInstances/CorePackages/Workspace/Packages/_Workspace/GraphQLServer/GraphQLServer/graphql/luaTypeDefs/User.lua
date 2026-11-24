-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
return "  interface User {\n    id: ID!\n    displayName: String!\n  }\n\n  type Player implements User {\n    id: ID!\n    displayName: String!\n    avatarHeadshot: String!\n  }\n\n  type Query {\n    me: User!\n    user(id: ID!): User!\n  }\n"
