<script>
	import { SvelteToast } from '@zerodevx/svelte-toast';
	import { onDestroy, onMount } from 'svelte';
	import Post from '../components/Post.svelte';
	import { getPosts, posts } from '../stores/posts';
	import { userStore } from '../stores/users';

    /**
	 * @type {any[]}
	 */
    let allPosts;
    /**
	 * @type {any}
	 */
    let user = {};
    
    
    onMount(() => {
        getPosts()
    })
    
    const unsubUser = userStore.subscribe((val) => user = val)
    const unsubPost = posts.subscribe(value => {
        allPosts = value;
	});

    onDestroy(unsubUser)
    onDestroy(unsubPost)
</script>

<style>
</style>

<div class="home__container">
    <SvelteToast/>
    <h1>Dequeued</h1>
    <p>{user ? `Hello ${user.username}` : "Please Login!"}</p>
    <div class="posts">
        {#each allPosts as post}
            <Post post={post}/>
        {/each}
    </div>
</div>