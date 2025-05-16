local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
    s({ trig = "sniptest" }, { t "hello, world!" }),
    s({ trig = "f", name = "LaTeX figure" }, fmt([[
        \begin{figure}[H]
            \centering
            \includegraphics[width=0.7\textwidth]{<filename>}
            \caption{<caption>}
            \label{fig:<label>}
        \end{figure}
        ]],
        {
            filename = i(1),
            caption = i(2),
            label = i(3),
        },
        {
            delimiters = "<>"
        })
    ),
    s({ trig = "item", name = "LaTeX dotted list" }, fmt([[
        \begin{itemize}
            <a>
        \end{itemize}
        ]],
        {
            a = i(1),
        },
        {
            delimiters = "<>"
        })
    ),
    s({ trig = "enum", name = "LaTeX enumerated list" }, fmt([[
        \begin{enumerate}
            <a>
        \end{enumerate}
        ]],
        {
            a = i(1),
        },
        {
            delimiters = "<>"
        })
    ),
    s({ trig = "s", name = "LaTeX section" }, fmt("\\section{<name>}", { name = i(1) }, { delimiters = "<>" })),
    s({ trig = "ss", name = "LaTeX subsection" }, fmt("\\subsection{<name>}", { name = i(1) }, { delimiters = "<>" })),
    s({ trig = "sss", name = "LaTeX subsubsection" },
        fmt("\\subsubsection{<name>}", { name = i(1) }, { delimiters = "<>" })),
    s({ trig = "p", name = "LaTeX paragraph" }, fmt("\\paragraph{<name>}", { name = i(1) }, { delimiters = "<>" })),
    s({ trig = "b", name = "LaTeX bold text" }, fmt("\\textbf{<a>}", { a = i(1) }, { delimiters = "<>" })),
    s({ trig = "e", name = "LaTeX emphasized text" }, fmt("\\emph{<a>}", { a = i(1) }, { delimiters = "<>" })),
    s({ trig = "u", name = "LaTeX underlined text" }, fmt("\\emph{<a>}", { a = i(1) }, { delimiters = "<>" })),
    s({ trig = "r", name = "LaTeX reference" }, fmt("\\ref{<a>}", { a = i(1) }, { delimiters = "<>" })),
    s({ trig = "l", name = "LaTeX label" }, fmt("\\ref{<a>}", { a = i(1) }, { delimiters = "<>" })),
    s({ trig = "i", name = "LaTeX item" }, t "\\item "),
}
