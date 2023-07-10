// Usage: @DocsId("relative-id")
// Group 1 = id
const annoDocsIdRE = /@DocsId\((?:\"([^"]+)\")\)/

// Usage: @DocsWidget("title"[, "desc"])
// Group 1 = title
// Group 2 = desc
const annoDocsWidgetRE = /@DocsWidget\((?:\"([^"]+)\")(?:,\s*"([^"]+)")?\)/

// Usage: @DocsDemo("title"[, "desc"])
// Group 1 = title
// Group 2 = desc
const annoDocsDemoRE = /@DocsDemo\((?:"([^"]+)")(?:,\s*"([^"]+)")?\)/g

// Usage: @DocsDemo
// Match = end of @DocsDemo()
const annoDocsDemoEndRE = /(?:\/\/\/?| |\*)*@DocsDemo(?!\()/

// Usage: @DocsProp("field", "type", "desc")
// Group 1: field name
// Group 2: type
// Group 3: desc
const annoDocsPropRE = /@DocsProp\("(\w+)", "([^"]+)"(?:, "([^"]*)")?\)/g

// Matches = "\n"s to trim
const dartCodeTrimRE = /^\n|\n\s*$/gm

// Match = space chars to shrink
const dartCodeLeadingSpacesRE = /^\s*(?=\w)/

export type DocsWidget = {
  id: string
  title: string
  desc: string
  demos: DocsDemo[]
  props: DocsProp[]
}

export type DocsDemo = {
  title: string
  desc: string
  code: string
}

export type DocsProp = {
  name: string
  type: string
  desc: string
}

function read(
  code: string,
  restoreWidget?: (id: string) => DocsWidget | undefined
): DocsWidget | null {
  // read widget id
  const idMA = code.match(annoDocsIdRE)
  if (!idMA?.[1]) return null
  const widget = restoreWidget?.(String(idMA[1])) ?? {
    id: String(idMA[1]),
    title: '',
    desc: '',
    demos: [],
    props: [],
  }

  const demosMap = new Map(widget.demos.map((demo) => [demo.title, demo]))

  // read widget title
  const defMA = code.match(annoDocsWidgetRE)
  if (defMA?.[1]) widget.title = String(defMA[1])
  if (defMA?.[2]) widget.desc = String(defMA[2])

  for (let ma of code.matchAll(annoDocsDemoRE)) {
    const { index } = ma
    if (!index || !ma[1]) continue
    const demo = demosMap.get(ma[1]) ?? { title: ma[1], desc: '', code: '' }

    // read desc
    if (ma[2]) demo.desc = String(ma[2])

    const start = index + ma[0].length
    let end: number | undefined
    // search @DocsDemoEnd from start
    const docsEndMA = code.substring(start).match(annoDocsDemoEndRE)
    if (docsEndMA?.index) end = start + docsEndMA.index

    demo.code = repairDartCodeIndent(code.substring(start, end))

    demosMap.set(demo.title, demo)
  }
  widget.demos = Array.from(demosMap.values())

  for (let ma of code.matchAll(annoDocsPropRE)) {
    if (!ma[1] || !ma[2]) continue
    const props: DocsProp = {
      name: String(ma[1]),
      type: String(ma[2]),
      desc: '-',
    }

    // read desc
    if (ma[3]) props.desc = String(ma[3])

    widget.props.push(props)
  }

  return widget.id == '' ? null : widget
}

function repairDartCodeIndent(code: string): string {
  const trimCode = code.replaceAll(dartCodeTrimRE, '')
  const spacesLen = trimCode.match(dartCodeLeadingSpacesRE)?.[0]?.length ?? 0
  const spacesShrinkRE = RegExp('^\\s{' + spacesLen + '}', 'gm')
  return trimCode.replaceAll(spacesShrinkRE, '')
}

export { read }
export default { read }
