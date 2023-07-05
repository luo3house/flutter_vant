<template>
  <div class="boundary">
    <div :hidden="show">
      <a
        class="trigger"
        title="Open simulator or open in new tab"
        :href="url"
        target="__blank"
        @click="onOpen"
      >
        <IconPhone />
      </a>
    </div>
    <template v-if="render">
      <div class="simulator" :style="show ? '' : 'display: none'">
        <div class="simulator__bar">
          <button title="Close simulator" @click="onClose">
            <IconClose />
          </button>
        </div>
        <iframe
          class="simulator__view"
          :src="url"
          referrerpolicy="no-referrer"
        />
      </div>
    </template>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'
import { useDebounceFn } from '@vueuse/core'
// @ts-ignore
import IconPhone from './IconPhone.vue'
// @ts-ignore
import IconClose from './IconClose.vue'

const __STORAGE_KEY_SIMULATOR_PREFER = '__simulator_prefer'

const isMatchMediaSupport =
  'matchMedia' in window && typeof window.matchMedia == 'function'

const isLargeScreen = () =>
  isMatchMediaSupport && window.matchMedia('(min-width: 1024px)').matches

const shouldOpenSimulator = () =>
  isMatchMediaSupport && window.matchMedia('(min-width: 360px)').matches

const loadShowPrefer = () =>
  localStorage.getItem(__STORAGE_KEY_SIMULATOR_PREFER) !== 'false'

const saveShowPrefer = useDebounceFn((flag: boolean) => {
  localStorage.setItem(__STORAGE_KEY_SIMULATOR_PREFER, String(flag))
}, 800)

const show = ref(isLargeScreen() && loadShowPrefer())

const render = ref(show.value)

watch(
  () => show.value,
  () => (render.value = show.value || render.value),
  { immediate: true }
)

const onOpen = (e: Event) => {
  if (shouldOpenSimulator()) {
    e.preventDefault()
    show.value = true
    saveShowPrefer(show.value)
  }
}
const onClose = () => {
  show.value = false
  saveShowPrefer(show.value)
}

const url = String(
  import.meta.env.VITE_DEMO_VIEW_BASEURL ?? import.meta.env.BASE_URL ?? '/'
)
</script>

<style scoped lang="less">
.boundary {
  position: fixed;
  bottom: 0;
  right: 0;
  padding-right: 24px;
  padding-bottom: 24px;
  z-index: 99999;
}

.icon {
  width: 40px;
  height: 40px;
  color: var(--vp-c-text-1);
  display: block;
  padding: 8px;
  background-color: #fcfcfc;
  border-radius: 8px;
  box-shadow: 0 0 2px #666666;

  & svg,
  img {
    width: 100%;
    height: 100%;
  }
}

.trigger {
  .icon();
}

.simulator {
  display: flex;
  flex-direction: row-reverse;
  align-items: end;

  &__bar {
    display: flex;
    justify-content: end;
    button {
      margin-left: 4px;
      .icon();
    }
  }
  &__view {
    border: 1px solid #cdcdcd;
    border-radius: 16px;
    background-color: #fcfcfc;
    width: 375px;
    height: 667px;
  }
}
</style>
