import type { DocsDemo } from '../.vitepress/docs-collector/reader'
import { docsWidgets } from '../docs-widgets'

export default {
  async paths() {
    return docsWidgets.map((widget) => {
      return {
        params: {
          ...widget,
          id: widget.id,
        },
        content: writeDemosMarkdown(widget.demos),
      }
    })
  },
}

// https://github.com/vuejs/vitepress/issues/2315
function writeDemosMarkdown(demos: DocsDemo[]): string {
  return demos
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
}
