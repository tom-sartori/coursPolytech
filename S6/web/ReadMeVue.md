# Notes VueJS

https://www.vuemastery.com/courses/intro-to-vue-3

## Installation

```html
<script src="https://unpkg.com/vue@3"></script>
```

## Create app

```js
const app = Vue.createApp({
    data() {
        return {
            product: 'Socks'
        }
    }
})
```

```html
<h1>{{product}}</h1>

<script>
  const mountedApp = app.mount('#app')
</script>
```

## Attribute bindig 

```js
const app = Vue.createApp({
    data() {
        return {
            product: 'Socks',
            image: './assets/images/socks_green.jpg'
        }
    }
})
```

```html
<img v-bind:src="image">   || <img :src="image">
<img :alt="description">
<a :href="url"></a>
<div :class="isActive"></div>
```

## Conditional rendering 

```js
<p v-if="inventory > 10">In stock</p>
<p v-if="0 < inventory && inventory <= 10">Almost sold out ! </p>
<p v-else>Out of stock</p>
```


## List rendering 

```js
<ul>
    <li v-for="detail in details">{{ detail }}</li>
</ul>
```


## Event handling 

```html
<button class="button" v-on:click="cart++" >Add to Cart</button>
||
<button class="button" @:click="addToCart" >Add to Cart</button>
```

```js
const app = Vue.createApp({
    data() {
        return {
            cart:0,
            product: 'Socks',
            image: './assets/images/socks_blue.jpg',
            inStock: true,
            details: ['50% cotton', '30% wool', '20% polyester'],
            variants: [
                { id: 2234, color: 'green', image: './assets/images/socks_green.jpg' },
                { id: 2235, color: 'blue', image: './assets/images/socks_blue.jpg' },
            ]
        }
    },
    methods: {
        addToCart () {
            this.cart++
        }
    }
})
```

Dans un for 

```html
<div v-for="variant in variants" :key="variant.id" @mouseover="updateImage(variant.image)" >{{ variant.color }}</div>
```


## Style binding 

```html
<button 
        class="button" 
        :class="{disabledButton: !inStock}" 
        :disabled="!inStock" 
        @click="addToCart"
>Add to Cart</button>
```


## Computed properties 
```js
computed: {
    title() {
        return this.brand + ' ' + this.product
    }
```


## Component 

```html
<div id="app">
    <div class="nav-bar"></div>

    <div class="cart">Cart({{ cart }})</div>
    <product-display :premium="premium"></product-display>

</div>
```

File productDisplay : 

```js
app.component('product-display', {
    props: {
        premium: {
            type: Boolean,
            required: true
        }
    },
    template:
    /*html*/
        `<div class="product-display">
        <div class="product-container">
          <div class="product-image">
            <img v-bind:src="image">
          </div>
          <div class="product-info">
            <h1>{{ title }}</h1>

            <p v-if="inStock">In Stock</p>
            <p v-else>Out of Stock</p>
            
            <p>Shipping {{ shipping }}</p>
            <ul>
              <li v-for="detail in details">{{ detail }}</li>
            </ul>

            <div 
              v-for="(variant, index) in variants" 
              :key="variant.id" 
              @mouseover="updateVariant(index)" 
              class="color-circle" 
              :style="{ backgroundColor: variant.color }">
            </div>
            
            <button class="button" :class="{ disabledButton: !inStock }" :disabled="!inStock" v-on:click="addToCart">Add to Cart</button>
          </div>
        </div>
      </div>`,
    data() {
        return {
            cart: 0,
            product: 'Socks',
            brand: 'Vue Mastery',
            selectedVariant: 0,
            details: ['50% cotton', '30% wool', '20% polyester'],
            variants: [
                { id: 2234, color: 'green', image: './assets/images/socks_green.jpg', quantity: 50 },
                { id: 2235, color: 'blue', image: './assets/images/socks_blue.jpg', quantity: 0 },
            ]
        }
    },
    methods: {
        addToCart() {
            this.cart += 1
        },
        updateVariant(index) {
            this.selectedVariant = index
        }
    },
    computed: {
        title() {
            return this.brand + ' ' + this.product
        },
        image() {
            return this.variants[this.selectedVariant].image
        },
        inStock() {
            return this.variants[this.selectedVariant].image
        },
        shipping() {
            if (this.premium) {
                return 'free'
            }
            else {
                return '3 balles'
            }
        }
    }
})
```

File main.js 

```js
const app = Vue.createApp({
    data() {
        return {
            cart: 0,
            premium: true
        }
    },
    methods: {

    },
})
```


## Communicating events 

File ProductDisplay.js
```js
addToCart() {
    this.$emit('add-to-cart', this.variants[this.selectedVariant].id)
},
```

```html
<product-display :premium="premium" @add-to-cart="updateCart"></product-display>
```


