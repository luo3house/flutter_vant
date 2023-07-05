<script setup>
import DefaultTheme from 'vitepress/theme'
import DemoView from './components/DemoView.vue'

const { Layout } = DefaultTheme
</script>

<template>
  <Layout>
    <!-- https://vitepress.dev/guide/extending-default-theme#layout-slots -->
    <template #doc-after>
      <ClientOnly>
        <DemoView />
      </ClientOnly>
    </template>
  </Layout>
</template>
