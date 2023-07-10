import type { DocsDemo, DocsWidget } from '../.vitepress/docs-collector/reader'
import { docsWidgets } from '../docs-widgets'

export default {
  async paths() {
    return docsWidgets.map((widget) => {
      return {
        params: {
          ...widget,
          id: widget.id,
        },
        content: writeDocsWidgetMarkdown(widget),
      }
    })
  },
}

// https://github.com/vuejs/vitepress/issues/2315
function writeDocsWidgetMarkdown(widget: DocsWidget): string {
  const demos = widget.demos
    .map(
      (demo) => `
### ${demo.title}

${demo.desc}

~~~dart
${demo.code}
~~~
`
    )
    .join('\n')

  const propRows = widget.props
    .map(
      ({ name, type, desc }) =>
        `| \`${name}\` | \`${type.replaceAll('|', '\\|')}\` | ${desc} |`
    )
    .join('\n')

  return `
## 代码演示

${demos}


## API

| Props | 类型 | 描述 |
| - | - | - |
${propRows}
    `
}
