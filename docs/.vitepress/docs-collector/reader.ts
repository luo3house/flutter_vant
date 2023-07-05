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

// Matches = "\n"s to trim
const dartCodeTrimRE = /^\n|\n\s*$/gm

// Match = space chars to shrink
const dartCodeLeadingSpacesRE = /^\s*(?=\w)/

export type DocsWidget = {
  id: string
  title: string
  desc: string
  demos: DocsDemo[]
}

export type DocsDemo = {
  title: string
  desc: string
  code: string
}

function read(code: string): DocsWidget | null {
  const widget: DocsWidget = {
    id: '',
    title: '',
    desc: '',
    demos: [],
  }

  // read widget id
  const idMA = code.match(annoDocsIdRE)
  if (idMA?.[1]) widget.id = String(idMA[1])

  // read widget title
  const defMA = code.match(annoDocsWidgetRE)
  if (defMA?.[1]) widget.title = String(defMA[1])
  if (defMA?.[2]) widget.desc = String(defMA[2])

  for (let ma of code.matchAll(annoDocsDemoRE)) {
    const demo: DocsDemo = {
      title: '',
      desc: '',
      code: '',
    }
    const { index } = ma
    if (!index) continue

    // read demo title & desc
    if (ma[1]) demo.title = String(ma[1])
    if (ma[2]) demo.desc = String(ma[2])

    const start = index + ma[0].length
    let end: number | undefined
    // search @DocsDemoEnd from start
    const docsEndMA = code.substring(start).match(annoDocsDemoEndRE)
    if (docsEndMA?.index) end = start + docsEndMA.index

    demo.code = repairDartCodeIndent(code.substring(start, end))

    widget.demos.push(demo)
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
