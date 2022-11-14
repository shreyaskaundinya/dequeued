import { writable } from 'svelte/store';

export const posts = writable([]);

export const getPosts = async () => {
	fetch('http://localhost:5000/posts')
		.then((res) => res.json())
		.then((data) => posts.update(() => data))
		.catch((err) => console.error(err));
};
