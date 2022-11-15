<script>
	import { SvelteToast } from '@zerodevx/svelte-toast';
	import { onMount } from 'svelte';
	import Post from '../components/Post.svelte';
	import { getPosts, posts } from '../stores/posts';

    /**
	 * @type {any[]}
	 */
    let allPosts;

    onMount(() => {
        getPosts()
    })

    posts.subscribe(value => {
		allPosts = value;
	});

</script>

<style>
</style>

<div class="home__container">
    <SvelteToast/>
    <h1>Dequeued</h1>
    <div class="posts">
        {#each allPosts as post}
            <Post post={post}/>
        {/each}
    </div>
</div>