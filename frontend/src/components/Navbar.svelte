<style>
    nav {
        display: flex;
        flex-direction: column;
        height: 100vh;
        padding: 1rem;
        position: sticky;
        top: 0;
    }
    ul {
        list-style-type: none;
        margin: 0;
        padding: 3rem 0;
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }
    a {
        text-decoration: none;
        color: #000;
        font-size: 1.2rem;
    }
    header {
        font-size: 2rem;
        font-weight: 900;
    }
</style>
<nav>
    <header>Dequeued</header>
    <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/explore">Explore</a></li>
        <li><a href="/settings">Settings</a></li>
    </ul>

    <div class="nav__actions">
        <button>Enqueue Post + </button>
    </div>
</nav>