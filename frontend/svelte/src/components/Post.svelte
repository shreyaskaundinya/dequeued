<script>
    let upvotes = 0;
    let comments = 0;

    /**
	 * @type {{ title: any; content: any; parent_post: any;}}
	 */
     export let post;
</script>

<div class="post">
    <div class="top">
        <p class="title">{post.title}</p>
        <p class="content">{post.content}</p>
    </div>
    <div class="bottom">
        <div class="upvote">Upvote ({upvotes})</div>
        <div class="comment">Comment ({comments})</div>
    </div>
</div>

<style>
    .post {
        border: 1px solid;
        margin: 1rem 0;
    }
    .title {
        margin-bottom: 1rem;
        padding-bottom: 0.5rem;
        font-weight: 900;
    }

    .top {
        padding: 1rem;
    }

    .bottom{
        display: flex;
        justify-content: space-around;
        border-top: 1px solid;
    }

    .upvote {
        flex: 1;
        text-align: center;
        border-right: 1px solid black;
        padding: 1rem;
    }

    .comment {
        text-align: center;
        flex: 1;
        padding: 1rem;
    }
</style>