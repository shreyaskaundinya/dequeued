import produce from 'immer';
import create from 'zustand';

export const usePostsStore = create((set) => ({
    posts: [],
    setPosts: (posts) => set((state) => ({ posts: posts })),
    updateUpvotes: (id, new_upvotes) =>
        set(
            produce((state) => {
                const post = state.posts.find((p) => p.id === id);
                post.upvotes = new_upvotes;
            })
        ),
    updatePost: (id, new_post) => {
        set(
            produce((state) => {
                let post = state.posts.find((p) => p.id === id);
                post.title = new_post.title;
                post.content = new_post.content;
            })
        );
    },
    removePost: (id) => {
        set((state) => ({ posts: state.posts.filter((p) => p.id !== id) }));
    },
}));

export const getPosts = async (user) => {
    const resData = await fetch('http://localhost:5000/posts/get', {
        method: 'POST',
        body: JSON.stringify({ user_id: user?.id }),
    });
    if (resData.ok) {
        const data = await resData.json();
        return [data.data, null];
    } else {
        const data = await resData.json();
        return [null, data.message];
    }
};
