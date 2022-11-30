export default function Input(props) {
    return (
        <label>
            <span>{props.name}</span>
            <input {...props} />
        </label>
    );
}
