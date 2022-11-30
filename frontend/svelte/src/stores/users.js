/* eslint-disable @typescript-eslint/ban-ts-comment */
// @ts-nocheck
import { writable } from 'svelte/store';

export const userStore = writable(null);

export const getUser = async (user_details) => {
	let error = null;
	fetch('http://localhost:5000/user', {
		method: 'POST',
		body: JSON.stringify(user_details)
	})
		.then((res) => res.json())
		.then((data) => userStore.update(() => data))
		.catch((err) => {
			console.error(err);
			error = err;
		});
	return error;
};
