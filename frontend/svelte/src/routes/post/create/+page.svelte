<script>
    // @ts-nocheck
	import { SvelteToast, toast } from '@zerodevx/svelte-toast';

    let post = {
        user_id: 1,
        parent_id: -1,
        "id": -1,
    };

    const handleChange = (e) => {
        post[e.target.name] = e.target.value; 
    }

    const handleAddPost = (e) => {
        e.preventDefault()
        console.log(post)
        fetch("http://localhost:5000/posts", {
            method: "POST",
            "content-type":"application/json",
            body: JSON.stringify(post)
        }).then(() => {
            toast.push("Successfully enqueued your post!")
        }).catch((err) => {
            toast.push("ERROR")
        })
    }

    

</script>


<div>
    <SvelteToast/>
    <h1>Create Post</h1>
    <form class="post-form" on:submit={handleAddPost}>
        <label>
            Title
            <input name="title" on:change={handleChange}/>
        </label>
        <label>
            Content
            <textarea name="content" on:change={handleChange}/>
        </label>
        <button>Add</button>
    </form>
</div>

<style>
    .post-form {
        display: flex;
        flex-direction: column;
        gap:1rem;
    }

    label {
        display: flex;    
        flex-direction: column;
    }
</style>