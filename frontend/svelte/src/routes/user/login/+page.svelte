<script>
    // @ts-nocheck

	import { enhance } from '$app/forms';
	import { SvelteToast } from '@zerodevx/svelte-toast';

    const handleLogin = ({form, data, action, cancel}) => {
        return async ({result}) => {
            
        }
    }

</script>


<div>
    <SvelteToast/>
    
    <h1>Login User</h1>
    <form class="form" method="POST" action="?/login" use:enhance={handleLogin}>
        <label>
            username
            <input name="username"/>
            <!-- <input name="username" on:change={handleLoginChange}/> -->
        </label>
        <label>
            password
            <input type="password" name="password"/>
            <!-- <input type="password" name="password" on:change={handleLoginChange}/> -->
        </label>
        <button>Login</button>
        <a href="/">Go to Feed</a>
    </form>
    
    <div class="breaker"></div>

    <h1>SignUp User</h1>
    
    <form class="form" method="POST" action="?/signup">
        <label>
            username
            <input name="username"/>
            <!-- <input name="username" on:change={handleSignupChange}/> -->
        </label>
        <label>
            name
            <input name="name"/>
            <!-- <input name="name" on:change={handleSignupChange}/> -->
        </label>
        <label>
            password
            <input type="password" name="password"/>
            <!-- <input type="password" name="password" on:change={handleSignupChange}/> -->
        </label>
        <button>Sign Up</button>
    </form>
</div>

<style>
    .form {
        display: flex;
        flex-direction: column;
        gap:1rem;
    }

    label {
        display: flex;    
        flex-direction: column;
    }

    .breaker {
        margin: 4rem 0;
    }
</style>