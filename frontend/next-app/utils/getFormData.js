export default function getFormData(form) {
    return Object.fromEntries(new FormData(form).entries());
}
