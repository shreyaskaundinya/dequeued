module.exports = {
    content: [
        './pages/**/*.{js, ts,jsx, tsx}',
        './src/components/**/*.{js, ts,jsx, tsx}',
    ],
    theme: {
        extend: {
            colors: {
                hallored: '#ac1b1d',
            },
            fontSize: {
                'step--2': 'clamp(0.99rem, 1.12rem + -0.68vw, 0.64rem)',
                'step--1': 'clamp(1.05rem, 1.15rem + -0.5vw, 0.8rem)',
                'step-0': 'clamp(1.13rem, 1.17rem + -0.24vw, 1rem)',
                'step-1': 'clamp(1.2rem, 1.18rem + 0.1vw, 1.25rem)',
                'step-2': 'clamp(1.28rem, 1.17rem + 0.55vw, 1.56rem)',
                'step-3': 'clamp(1.37rem, 1.14rem + 1.14vw, 1.95rem)',
                'step-4': 'clamp(1.46rem, 1.07rem + 1.92vw, 2.44rem)',
                'step-5': 'clamp(1.56rem, 0.97rem + 2.92vw, 3.05rem)',
                'step-6': 'clamp(1.66rem, 0.82rem + 4.2vw, 3.82rem)',
                'step-7': 'clamp(1.77rem, 0.6rem + 5.85vw, 4.77rem)',
                'step-8': 'clamp(1.89rem, 0.3rem + 7.94vw, 5.96rem)',
                'step-9': 'clamp(2.02rem, -0.1rem + 10.6vw, 7.45rem)',
                'step-10': 'clamp(2.6rem, -0.44rem + 12.4vw, 13rem)',
                'step-11': 'clamp(3.4rem, -0.44rem + 13.4vw, 16rem)',
                'step-12': 'clamp(4.1rem, -0.44rem + 14.4vw, 20rem)',
            },
            fontFamily: {
                redhat: ['REDHAT', 'sans-serif'],
                poppins: ['Poppins', 'sans-serif'],
                agency: ['Agency FB', 'arial'],
            },
        },
    },
    plugins: [],
};
