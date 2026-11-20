-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    definitions = {{
        selectionSet = {
            kind = "SelectionSet",
            selections = {{
                selectionSet = {
                    kind = "SelectionSet",
                    selections = {
                        {
                            arguments = {},
                            name = { value = "id", kind = "Name" },
                            kind = "Field",
                            directives = {}
                        },
                        {
                            selectionSet = {
                                kind = "SelectionSet",
                                selections = {
                                    {
                                        arguments = {},
                                        name = { value = "inExperienceCombinedName", kind = "Name" },
                                        kind = "Field",
                                        directives = {}
                                    },
                                    {
                                        arguments = {},
                                        name = { value = "combinedName", kind = "Name" },
                                        kind = "Field",
                                        directives = {}
                                    },
                                    {
                                        arguments = {},
                                        name = { value = "username", kind = "Name" },
                                        kind = "Field",
                                        directives = {}
                                    },
                                    {
                                        arguments = {},
                                        name = { value = "displayName", kind = "Name" },
                                        kind = "Field",
                                        directives = {}
                                    },
                                    {
                                        arguments = {},
                                        name = { value = "platformName", kind = "Name" },
                                        kind = "Field",
                                        directives = {}
                                    }
                                }
                            },
                            arguments = {},
                            name = { value = "names", kind = "Name" },
                            kind = "Field",
                            directives = {}
                        }
                    }
                },
                arguments = {{
                    value = {
                        kind = "Variable",
                        name = { value = "userIds", kind = "Name" }
                    },
                    kind = "Argument",
                    name = { value = "userIds", kind = "Name" }
                }},
                name = { value = "userProfiles", kind = "Name" },
                kind = "Field",
                directives = {}
            }}
        },
        directives = {},
        name = { value = "UserProfiles", kind = "Name" },
        operation = "query",
        kind = "OperationDefinition",
        variableDefinitions = {{
            type = {
                kind = "NonNullType",
                type = {
                    kind = "ListType",
                    type = {
                        kind = "NamedType",
                        name = { value = "String", kind = "Name" }
                    }
                }
            },
            directives = {},
            kind = "VariableDefinition",
            variable = {
                kind = "Variable",
                name = { value = "userIds", kind = "Name" }
            }
        }}
    }},
    kind = "Document"
}
