<script>
	import Navbar from "../components/Navbar.svelte";

</script>
<style>
    .container {
        display: flex;
        gap: 2rem;
        margin: 0;
        padding: 0;
        max-width: 1080px;
        margin: 0 auto;
    }

    .page__container{
        padding: 1rem;
        width: 100%;
    }

</style>
<div class="container">
    <Navbar/>

    <div class="page__container">
        <slot></slot>
    </div>
</div>